import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'contact_model.dart';
import 'posting_model.dart';

class Booking {
  late String? id;
  late Posting? posting;
  late Contact? contact;
  List<DateTime>? dates;

  Booking({
    this.id,
    this.posting,
    this.contact,
    this.dates,
  });

  void createBooking(Posting posting, Contact contact, List<DateTime> dates) {
    posting = posting;
    contact = contact;
    dates = dates;
    dates.sort();
  }

  String getFirstDate() {
    return DateFormat('yyyy-MM-dd').format(dates!.first);
  }

  String getLastDate() {
    return DateFormat('yyyy-MM-dd').format(dates!.last);
  }

  Future<void> getBookingInfoFromFirestoreFromUser(
      Contact contact, DocumentSnapshot snapshot) async {
    this.contact = contact;
    List<Timestamp> timestamps = List<Timestamp>.from(snapshot['dates'] ?? []);
    dates = [];
    for (var timestamp in timestamps) {
      dates!.add(timestamp.toDate());
    }

    List<DateTime>.from(snapshot['dates']);
    String postingID = snapshot['postingID'] ?? '';

    posting = Posting(id: postingID);
    await posting!.getPostingInfoFromFirestore();
    await posting!.getFirstImageFromStorage();
  }

  Future<void> getBookingInfoFromFirestoreFromPosting(
      Posting posting, DocumentSnapshot snapshot) async {
    this.posting = posting;
    List<Timestamp> timestamps = List<Timestamp>.from(snapshot['dates'] ?? []);
    dates = [];
    for (var timestamp in timestamps) {
      dates!.add(timestamp.toDate());
    }

    String contactId = snapshot['userID'] ?? '';
    String fullName = snapshot['name'] ?? '';
    _loadContactInfo(contactId, fullName);
  }

  void _loadContactInfo(String id, String fullName) {
    String firstName = fullName.split(" ")[0];
    String lastName = fullName.split(" ")[1];

    contact = Contact(id: id, firstName: firstName, lastName: lastName);
  }
}
