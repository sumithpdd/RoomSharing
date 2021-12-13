// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
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

  void becomeHost() {
    isHost = true;
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

  void makeNewBooking(Booking newBooking) {
    bookings.add(newBooking);
  }

  void addSavedPosting(Posting posting) {
    savedPostings.add(posting);
  }

  void removeSavedPosting(Posting posting) {
    savedPostings.removeWhere((post) => post.name == posting.name);
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

  void postNewReview(String text, double rating) {
    Review newReview = Review(
        contact: AppConstants.currentUser.createContactFromUser(),
        text: text,
        rating: rating,
        dateTime: DateTime.now());
    reviews.add(newReview);
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
}
