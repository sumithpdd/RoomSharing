import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_sharing/Models/contact_model.dart';

class Review {
  late Contact? contact;
  late String? text;
  late double? rating;
  late DateTime? dateTime;

  Review({this.contact, this.text, this.rating, this.dateTime});

  createReview(Contact contact, String text, double rating, DateTime dateTime) {
    contact = contact;
    text = text;
    rating = rating;
    dateTime = dateTime;
  }

  void getReviewInfoFromFirestore(DocumentSnapshot snapshot) {
    Timestamp timestamp = snapshot['dateTime'] ?? Timestamp.now();
    dateTime = timestamp.toDate();

    String fullName = snapshot['name'] ?? "";

    rating = snapshot['rating'].toDouble() ?? 2.5;
    text = snapshot['text'] ?? "";

    String contactID = snapshot['userID'] ?? "";
    _loadContactInfo(contactID, fullName);
  }

  void _loadContactInfo(String id, String fullName) {
    String firstName = fullName.split(" ")[0];
    String lastName = fullName.split(" ")[1];

    contact = Contact(id: id, firstName: firstName, lastName: lastName);
  }
}
