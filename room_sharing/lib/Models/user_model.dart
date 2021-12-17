// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:room_sharing/Models/booking_model.dart';
import 'package:room_sharing/Models/conversation_model.dart';
import 'package:room_sharing/Models/posting_model.dart';

import 'app_constants.dart';
import 'contact_model.dart';
import 'review_model.dart';

class User extends Contact {
  late String email;
  late String bio;
  late String city;
  late String country;
  late bool isHost;
  late bool isCurrentlyHosting;
  late double rating;
  late String password;

  late List<Booking> bookings;
  late List<Review> reviews;
  late List<Conversation> conversations;
  late List<Posting> savedPostings;
  late List<Posting> myPostings;
  late DocumentSnapshot snapshot;
  User({
    String id = "",
    String firstName = "",
    String lastName = "",
    MemoryImage? displayImage,
    this.email = "",
    this.bio = "",
    this.city = "",
    this.country = "",
  }) : super(
            id: id,
            firstName: firstName,
            lastName: lastName,
            displayImage: displayImage) {
    isHost = false;
    isCurrentlyHosting = false;
    rating = 0;
    bookings = [];
    reviews = [];
    conversations = [];
    savedPostings = [];
    myPostings = [];
  }

  void changeCurrentlyHosting(bool isHosting) {
    isCurrentlyHosting = isHosting;
  }

  Future<void> becomeHost() async {
    isHost = true;
    Map<String, dynamic> data = {
      "isHost": isHost,
    };
    await FirebaseFirestore.instance.doc('users/$id').update(data);
    changeCurrentlyHosting(true);
  }

  Contact createContactFromUser() {
    return Contact(
      id: id,
      firstName: firstName,
      lastName: lastName,
      displayImage: displayImage!,
    );
  }

  Future<void> addNewBookingToFirestore(Booking newBooking) async {
    Map<String, dynamic> bookingData = {
      'dates': newBooking.dates,
      'postingID': newBooking.posting!.id
    };

    await FirebaseFirestore.instance
        .doc('users/$id/bookings/${newBooking.id}')
        .set(bookingData);

    bookings.add(newBooking);
    await addNewBookingConversationFirestore(newBooking);
  }

  Future<void> addNewBookingConversationFirestore(Booking newBooking) async {
    Conversation conversation = Conversation();
    await conversation.addConversationToFireStore(newBooking.posting!.host!);
    String messageText =
        "Hi my name is ${AppConstants.currentUser.firstName} and I have"
        " just booked ${newBooking.posting!.name} from ${newBooking.dates!.first} to ${newBooking.dates!.last}";

    conversation.addMessageToFireStore(messageText);
  }

  Future<void> addSavedPosting(Posting posting) async {
    if (savedPostings.where((post) => post.id == posting.id).isNotEmpty) {
      return;
    }

    savedPostings.add(posting);

    List<String> savedPostingsIDs = [];

    savedPostings.forEach((posting) {
      savedPostingsIDs.add(posting.id);
    });

    Map<String, dynamic> data = {
      "savedPostingIDs": savedPostingsIDs,
    };
    await FirebaseFirestore.instance.doc('users/$id').update(data);
  }

  Future<void> removeSavedPosting(Posting posting) async {
    savedPostings.removeWhere((post) => post.id == posting.id);
    List<String> savedPostingsIDs = [];

    savedPostings.forEach((posting) {
      savedPostingsIDs.add(posting.id);
    });

    Map<String, dynamic> data = {
      "savedPostingIDs": savedPostingsIDs,
    };
    await FirebaseFirestore.instance.doc('users/$id').update(data);
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
    Map<String, dynamic> reviewData = {
      'dateTime': DateTime.now(),
      'name': AppConstants.currentUser.getFullName(),
      'rating': rating,
      'text': text,
      'userID': AppConstants.currentUser.id
    };
    await FirebaseFirestore.instance
        .collection('users/$id/reviews')
        .add(reviewData);
  }

  List<Booking> getPreviousTrips() {
    List<Booking> previousTrips = [];

    bookings.forEach((booking) {
      if (booking.dates!.last.compareTo(DateTime.now()) <= 0) {
        previousTrips.add(booking);
      }
    });
    return previousTrips;
  }

  List<Booking> getUpcomingTrips() {
    List<Booking> upcomingTrips = [];
    bookings.forEach((booking) {
      if (booking.dates!.last.compareTo(DateTime.now()) > 0) {
        upcomingTrips.add(booking);
      }
    });
    return upcomingTrips;
  }

  List<DateTime> getAllBookedDates() {
    List<DateTime> allBookedDates = [];
    myPostings.forEach((posting) {
      posting.bookings.forEach((booking) {
        allBookedDates.addAll(booking.dates!);
      });
    });
    return allBookedDates;
  }

  Future<void> getUserInfoFromFirestore() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    this.snapshot = snapshot;
    firstName = snapshot['firstName'] ?? "";
    lastName = snapshot['lastName'] ?? "";
    email = snapshot['email'] ?? "";
    bio = snapshot['bio'] ?? "";
    city = snapshot['city'] ?? "";
    country = snapshot['country'] ?? "";
    isHost = snapshot['isHost'] ?? false;
  }

  Future<void> getPersonalInfoFromFirestore() async {
    await getUserInfoFromFirestore();
    await getImageFromStorage();
    // List<String> conversationsIDs =
    //     List<String>.from(snapshot['conversationsIDs']);
    await getMyPostingFromFirestore();
    await getSavedPostingFromFirestore();
    await getAllBookingsFromFirestore();
  }

  Future<void> getMyPostingFromFirestore() async {
    List<String> myPostingIDs = List<String>.from(snapshot['myPostingIDs']);
    myPostingIDs.forEach((postingId) async {
      Posting newPosting = Posting(id: postingId);
      await newPosting.getPostingInfoFromFirestore();
      await newPosting.getAllBookingsFromFirestore();
      await newPosting.getAllImagesFromStorage();
      myPostings.add(newPosting);
    });
  }

  Future<void> getSavedPostingFromFirestore() async {
    List<String> savedPostingIds =
        List<String>.from(snapshot['savedPostingIDs']);
    savedPostingIds.forEach((postingId) async {
      Posting newPosting = Posting(id: postingId);
      await newPosting.getPostingInfoFromFirestore();
      await newPosting.getFirstImageFromStorage();

      savedPostings.add(newPosting);
    });
  }

  Future<void> getAllBookingsFromFirestore() async {
    bookings = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users/$id/bookings').get();

    snapshot.docs.map((doc) async {
      Booking newBooking = Booking();
      await newBooking.getBookingInfoFromFirestoreFromUser(
          createContactFromUser(), doc);
      bookings.add(newBooking);
    });
  }

  Future<void> addUserToFirestore() async {
    Map<String, dynamic> data = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "bio": bio,
      "city": city,
      "country": country,
      "isHost": false,
      "myPostingIDs": [],
      "savedPostingIDs": []
    };
    await FirebaseFirestore.instance.doc('users/$id').set(data);
  }

  Future<void> addImageToFirestore(File imageFile) async {
    Reference reference =
        FirebaseStorage.instance.ref().child('userImages/$id/profile_pic.jpg');
    await reference.putFile(imageFile).whenComplete(() {
      displayImage = MemoryImage(imageFile.readAsBytesSync());
    });
  }

  Future<void> updateUserInFirestore() async {
    Map<String, dynamic> data = {
      "firstName": firstName,
      "lastName": lastName,
      "bio": bio,
      "city": city,
      "country": country,
    };
    await FirebaseFirestore.instance.doc('users/$id').update(data);
  }

  Future<void> addPostingToMyPosting(Posting posting) async {
    myPostings.add(posting);

    List<String> myPostingIDs = [];

    myPostings.forEach((posting) {
      myPostingIDs.add(posting.id);
    });

    Map<String, dynamic> data = {
      "myPostingIDs": myPostingIDs,
    };
    await FirebaseFirestore.instance.doc('users/$id').update(data);
  }
}
