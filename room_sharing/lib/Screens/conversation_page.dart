// ignore_for_file: prefer_const_constructors, prefer_const_declarations, unused_import

import 'package:flutter/material.dart';
import 'package:room_sharing/Models/conversation_model.dart';
import 'package:room_sharing/Models/message_model.dart';
import 'package:room_sharing/Screens/guest_home_page.dart';
import 'package:room_sharing/Views/list_widgets.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class ConversationPage extends StatefulWidget {
  static final String routeName = '/ConversationPageRoute';
  final Conversation conversation;

  const ConversationPage({Key? key, required this.conversation})
      : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late Conversation _conversation;

  @override
  void initState() {
    _conversation = widget.conversation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppBarText(text: _conversation.otherContact.getFullName()),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _conversation.messages.length,
                    itemBuilder: (context, index) {
                      Message currentMessage = _conversation.messages[index];
                      return MessageListTile(message: currentMessage);
                    })),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 5 / 7,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Write a message',
                          contentPadding: EdgeInsets.all(20),
                          border: InputBorder.none),
                      minLines: 1,
                      maxLines: 5,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text('Send'),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
