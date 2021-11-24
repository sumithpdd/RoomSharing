import 'package:intl/intl.dart';

import 'contact_model.dart';
import 'posting_model.dart';

class Booking {
  final Posting posting;
  final Contact contact;
  final List<DateTime> dates;

  Booking({required this.posting, required this.contact, required this.dates});

  void createBooking(Posting posting, Contact contact, List<DateTime> dates) {
    posting = posting;
    contact = contact;
    dates = dates;
    dates.sort();
  }

  String getFirstDate(){
    return DateFormat('yyyy-MM-dd').format(dates.first);
  }
  String getLastDate(){
    return DateFormat('yyyy-MM-dd').format(dates.last);
  }
}
