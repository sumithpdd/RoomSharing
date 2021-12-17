import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Models/booking_model.dart';
import 'package:room_sharing/Models/review_model.dart';

import 'contact_model.dart';

class Posting {
  String id;
  String name;
  String type;
  double price;
  String description;
  String address;
  String city;
  String country;
  double rating;

  late Contact? host;

  late List<String> imageNames;
  late List<MemoryImage> displayImages;
  late List<String> amenities;

  late Map<String, int> beds;
  late Map<String, int> baths;
  late List<Booking> bookings;
  late List<Review> reviews;

  Posting({
    this.id = "",
    this.name = "",
    this.type = "",
    this.price = 0,
    this.description = "",
    this.address = "",
    this.city = "",
    this.country = "",
    this.rating = 0,
    this.host,
  }) {
    imageNames = [];
    displayImages = [];
    amenities = [];
    beds = {};
    baths = {};
    bookings = [];
    reviews = [];
  }

  int getNumGuests() {
    int numGuests = 0;
    numGuests += beds['small']!;
    numGuests += beds['medium']! * 2;
    numGuests += beds['large']! * 2;
    return numGuests;
  }

  // void setImages(List<String> imagePaths) {
  //   this.imageNames = imagePaths;
  //   for (var imagePath in imagePaths) {
  //     displayImages.add(AssetImage(imagePath));
  //   }
  // }

  String getFullAddress() {
    return address + ", " + city + ", " + country;
  }

  String getAmenitiesString() {
    if (amenities.isEmpty) {
      return "";
    }
    String amenitiesString = amenities.toString();
    return amenitiesString.substring(1, amenitiesString.length - 1);
  }

  String getBedroomText() {
    String text = "";
    if (beds["small"] != 0) {
      text += beds["small"].toString() + ' single/twin ';
    }
    if (beds["medium"] != 0) {
      text += beds["medium"].toString() + ' double ';
    }
    if (beds["large"] != 0) {
      text += beds["large"].toString() + ' queen/king ';
    }
    return text;
  }

  String getBathroomText() {
    String text = "";
    if (baths["full"] != 0) {
      text += baths["full"].toString() + ' full';
    }
    if (baths["half"] != 0) {
      text += baths["half"].toString() + ' half';
    }

    return text;
  }

  Future<void> makeNewBooking(List<DateTime> dates) async {
    Map<String, dynamic> bookingData = {
      'dates': dates,
      'name': AppConstants.currentUser.getFullName(),
      'userID': AppConstants.currentUser.id
    };

    DocumentReference reference = await FirebaseFirestore.instance
        .collection('postings/$id/bookings')
        .add(bookingData);

    Booking newBooking = Booking(
        id: reference.id,
        posting: this,
        contact: AppConstants.currentUser.createContactFromUser(),
        dates: dates);
    bookings.add(newBooking);
    await AppConstants.currentUser.addNewBookingToFirestore(newBooking);
  }

  List<DateTime> getAllBookedDates() {
    List<DateTime> dates = [];
    bookings.forEach((booking) {
      dates.addAll(booking.dates!);
    });
    return dates;
  }

  double getCurrentRating() {
    if (reviews.isEmpty) {
      return 4;
    }
    double rating = 0;

    reviews.forEach((review) {
      rating += review.rating!;
    });
    rating /= reviews.length;
    return rating;
  }

  Future<void> postNewReview(String text, double rating) async {
    // Review newReview = Review(
    //     contact: AppConstants.currentUser.createContactFromUser(),
    //     text: text,
    //     rating: rating,
    //     dateTime: DateTime.now());
    // reviews.add(newReview);
    Map<String, dynamic> reviewData = {
      'dateTime': DateTime.now(),
      'name': AppConstants.currentUser.getFullName(),
      'rating': rating,
      'text': text,
      'userID': AppConstants.currentUser.id
    };
    await FirebaseFirestore.instance
        .collection('postings/$id/reviews')
        .add(reviewData);
  }

  Future<void> getPostingInfoFromFirestore() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('postings').doc(id).get();
    getPostingInfoFromSnapshot(snapshot);
  }

  void getPostingInfoFromSnapshot(DocumentSnapshot snapshot) {
    address = snapshot['address'] ?? "";
    amenities = List<String>.from(snapshot['amenities']);
    address = snapshot['address'] ?? "";
    baths = Map<String, int>.from(snapshot['baths']);
    beds = Map<String, int>.from(snapshot['beds']);
    city = snapshot['city'];
    country = snapshot['country'];
    description = snapshot['description'];
    String hostID = snapshot['hostID'];
    host = Contact(id: hostID);

    imageNames = List<String>.from(snapshot['imageNames']);
    name = snapshot['name'];
    price = snapshot['price'].toDouble();
    rating = snapshot['rating'].toDouble();
    type = snapshot['type'];
  }

  Future<MemoryImage> getFirstImageFromStorage() async {
    if (displayImages.isNotEmpty) {
      return displayImages.first;
    }
    final String imagePath = "postingImages/$id/${imageNames.first}";
    print(imagePath);
    final imageData = await FirebaseStorage.instance
        .ref()
        .child(imagePath)
        .getData(1024 * 1024);

    displayImages.add(MemoryImage(imageData!));
    return displayImages.first;
  }

  Future<List<MemoryImage>> getAllImagesFromStorage() async {
    displayImages = [];
    for (var imageName in imageNames) {
      final String imagePath = "postingImages/$id/$imageName";
      final imageData = await FirebaseStorage.instance
          .ref()
          .child(imagePath)
          .getData(1024 * 1024);

      displayImages.add(MemoryImage(imageData!));
    }
    return displayImages;
  }

  Future<void> getHostFromFirestrore() async {
    await host!.getContactInfoFromFirestore();
    await host!.getImageFromStorage();
  }

  Future<void> getAllBookingsFromFirestore() async {
    bookings = [];
    await FirebaseFirestore.instance
        .collection('postings/$id/bookings')
        .get()
        .then((QuerySnapshot snapshot) {
      // ignore: avoid_function_literals_in_foreach_calls
      snapshot.docs.forEach((DocumentSnapshot document) {
        Booking newBooking = Booking();
        newBooking.getBookingInfoFromFirestoreFromPosting(this, document);
        bookings.add(newBooking);
      });
    });
  }

  Future<void> addPostingInfoToFirestore() async {
    setImageNames();
    Map<String, dynamic> data = {
      'address': address,
      'amenities': amenities,
      'baths': baths,
      'beds': beds,
      'city': city,
      'country': country,
      'description': description,
      'hostID': AppConstants.currentUser.id,
      'imageNames': imageNames,
      'name': name,
      'price': price,
      'rating': 2.5,
      'type': type,
    };
    DocumentReference reference =
        await FirebaseFirestore.instance.collection('postings').add(data);
    id = reference.id;
    await AppConstants.currentUser.addPostingToMyPosting(this);
  }

  void setImageNames() {
    imageNames = [];
    for (int i = 0; i < displayImages.length; i++) {
      imageNames.add('pic$i.jpg');
    }
  }

  Future<void> addImagesToFirestore() async {
    for (int i = 0; i < displayImages.length; i++) {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('postingImages/$id/$imageNames[i]');
      await reference.putData(displayImages[i].bytes).whenComplete(() {});
    }
  }

  Future<void> updatePostingInfoInFirestore() async {
    setImageNames();
    Map<String, dynamic> data = {
      'address': address,
      'amenities': amenities,
      'baths': baths,
      'beds': beds,
      'city': city,
      'country': country,
      'description': description,
      'hostID': AppConstants.currentUser.id,
      'imageNames': imageNames,
      'name': name,
      'price': price,
      'rating': rating,
      'type': type,
    };

    await FirebaseFirestore.instance.doc('postings/$id').update(data);
  }
}
