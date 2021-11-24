import 'package:room_sharing/Models/Conversation_model.dart';
import 'package:room_sharing/Models/booking_model.dart';
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
  late List<Posting> savedPosting;

  User({
    String firstName = "",
    String lastName = "",
    String imagePath = "",
    this.email = "",
    this.bio = "",
    this.city = "",
    this.country = "",
  }) : super(firstName: firstName, lastName: lastName, imagePath: imagePath) {
    isHost = false;
    isCurrentlyHosting = false;
    rating = 0;
    bookings = [];
    reviews = [];
    conversations = [];
    savedPosting = [];
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
        firstName: firstName, lastName: lastName, imagePath: imagePath);
  }

  void makeNewBooking(Booking newBooking) {
    bookings.add(newBooking);
  }

  void addSavedPosting(Posting posting) {
    savedPosting.add(posting);
  }

  void removeSavedPosting(Posting posting) {
    savedPosting.removeWhere((post) => post.name == posting.name);
  }

  double getCurrentRating() {
    if (reviews.isEmpty) {
      return 4;
    }
    double rating = 0;

    reviews.forEach((review) {
      rating += review.rating;
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
      if (booking.dates.last.compareTo(DateTime.now()) <= 0) {
        previousTrips.add(booking);
      }
    });
    return previousTrips;
  }
  List<Booking> getUpcomingTrips() {
    List<Booking> upcomingTrips = [];
    bookings.forEach((booking) {
      if (booking.dates.last.compareTo(DateTime.now()) > 0) {
        upcomingTrips.add(booking);
      }
    });
    return upcomingTrips;
  }

}
