// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:room_sharing/Screens/conversation_page.dart';
import 'package:room_sharing/Views/list_widgets.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: ListView.builder(
          itemCount: 2,
          itemExtent: MediaQuery.of(context).size.height / 7,
          itemBuilder: (context, index) {
            return InkResponse(
                onTap: (){
                  Navigator.pushNamed(context, ConversationPage.routeName);

                },
                child: ConversationListTile());
          }),
    );
  }
}
