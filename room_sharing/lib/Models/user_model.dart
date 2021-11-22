import 'package:room_sharing/Models/booking_model.dart';

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
    Review newReview = Review();
    newReview.createReview(AppConstants.currentUser.createContactFromUser(),
        text, rating, DateTime.now());
    reviews.add(newReview);
  }
}