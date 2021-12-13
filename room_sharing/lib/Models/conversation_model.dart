import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Models/contact_model.dart';
import 'package:room_sharing/Models/message_model.dart';

class Conversation {
  late String id;
  late Contact otherContact;
  late List<Message> messages;
  late Message lastMessage;

  Conversation() {
    otherContact = Contact();
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

  void getConversationInfoFromFirestore(DocumentSnapshot snapshot) {
    id = snapshot.id;
    String lastMessageText = snapshot['lastMessageText'] ?? '';

    Timestamp lastMessageTimestamp =
        snapshot['lastMessageDateTime'] ?? Timestamp.now();
    DateTime lastMessageDateTime = lastMessageTimestamp.toDate();

    lastMessage = Message();
    lastMessage.dateTime = lastMessageDateTime;
    lastMessage.text = lastMessageText;

    Map<String, String> userInfo =
        Map<String, String>.from(snapshot['userInfo']);
    userInfo.forEach((id, name) {
      if (id != AppConstants.currentUser.id) {
        otherContact = Contact(
          id: id,
          firstName: name.split(' ')[0],
          lastName: name.split(' ')[1],
        );
      }
    });
  }
}
