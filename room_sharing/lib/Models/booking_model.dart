import 'contact_model.dart';
import 'posting_model.dart';

class Booking {
  late Posting posting;
  late Contact contact;
  late List<DateTime> dates;

  void createBooking(Posting posting, Contact contact, List<DateTime> dates) {
    posting = posting;
    contact = contact;
    dates = dates;
  }
}
