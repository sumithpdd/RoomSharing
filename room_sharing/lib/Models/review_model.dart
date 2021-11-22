import 'package:room_sharing/Models/contact_model.dart';

class Review {
  late Contact contact;
  late String text;
  late double rating;
  late DateTime dateTime;

  createReview(Contact contact, String text, double rating, DateTime dateTime) {
    contact = contact;
    text = text;
    rating = rating;
    dateTime = dateTime;
  }
}
