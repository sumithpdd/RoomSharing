import 'package:room_sharing/Models/contact_model.dart';
import 'package:room_sharing/Models/message_model.dart';

class Conversation {
  late Contact otherContact;
  late List<Message> messages;
  late Message lastMessage;

  Conversation() {
    messages = [];
  }

  void createConversation(Contact otherContact, List<Message> messages) {
    otherContact = otherContact;
    messages = messages;
    if (messages.isNotEmpty) {
      lastMessage = messages.last;
    }
  }

  String getLastMessageText() {
    if (messages.isEmpty) {
      return "";
    } else {
      return messages.last.text;
    }
  }
  String getLastMessageDateTime() {
    if (messages.isEmpty) {
      return "";
    } else {
      return messages.last.getMessageDateTime();
    }
  }
}
