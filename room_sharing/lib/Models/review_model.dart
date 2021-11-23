import 'package:room_sharing/Models/contact_model.dart';

class Review {
  final Contact contact;
  final String text;
  final double rating;
  final DateTime dateTime;

  Review(
      {required this.contact,
      required this.text,
      required this.rating,
      required this.dateTime});

  createReview(Contact contact, String text, double rating, DateTime dateTime) {
    contact = contact;
    text = text;
    rating = rating;
    dateTime = dateTime;
  }
}
