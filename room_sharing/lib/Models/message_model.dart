import 'package:room_sharing/Models/app_constants.dart';

import 'contact_model.dart';

class Message {
  late Contact sender;
  late String text;
  late DateTime dateTime;

  void createMessage(Contact sender, String text, DateTime dateTime) {
    sender = sender;
    text = text;
    dateTime = dateTime;
  }

  String getMessageDateTime() {
    final DateTime now = DateTime.now();
    final today = now.day;

    if (dateTime.day == today) {
      return _getTime();
    } else {
      return _getDate();
    }
  }

  String _getDate() {
    String date = dateTime.toIso8601String().substring(5, 10);
    String month = date.substring(0, 2);
    int monthInt = int.parse(month);
    String monthName = AppConstants.monthDict[monthInt]!;
    String day = date.substring(3, 5);
    return monthName + "/" + day;
  }

  String _getTime() {
    String time = dateTime.toIso8601String().substring(11, 16);
    String hours = time.substring(0, 2);
    String minutes = time.substring(2);

    return hours + ":" + minutes;
  }
}
