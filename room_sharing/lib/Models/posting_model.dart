import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Models/booking_model.dart';
import 'package:room_sharing/Models/review_model.dart';

import 'contact_model.dart';

class Posting {
  final String name;
  final String type;
  final double price;
  final String description;
  final String address;
  final String city;
  final String country;
  final double rating;

  final Contact host;

  late List<String> imagePaths;
  late List<AssetImage> displayImages;
  late List<String> amenities;

  late Map<String, int> beds;
  late Map<String, int> baths;
  late List<Booking> bookings;
  late List<Review> reviews;

  Posting({
    this.name = "",
    this.type = "",
    this.price = 0,
    this.description = "",
    this.address = "",
    this.city = "",
    this.country = "",
    this.rating = 0,
    required this.host,
  }) {
    imagePaths = [];
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

  void setImages(List<String> imagePaths) {
    this.imagePaths = imagePaths;
    for (var imagePath in imagePaths) {
      displayImages.add(AssetImage(imagePath));
    }
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
      text += beds["small"].toString() + ' single/twin';
    }
    if (beds["medium"] != 0) {
      text += beds["medium"].toString() + ' double';
    }
    if (beds["large"] != 0) {
      text += beds["large"].toString() + ' queen/king';
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

  void makeNewBooking(List<DateTime> dates) {
    Booking newBooking = Booking();
    newBooking.createBooking(
        this, AppConstants.currentUser.createContactFromUser(), dates);
    bookings.add(newBooking);
  }

  List<DateTime> getAllBookedDates() {
    List<DateTime> dates = [];
    bookings.forEach((booking) {
      dates.addAll(booking.dates);
    });
    return dates;
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
