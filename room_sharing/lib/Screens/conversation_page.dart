// ignore_for_file: prefer_const_constructors, prefer_const_declarations, unused_import

import 'package:flutter/material.dart';
import 'package:room_sharing/Screens/guest_home_page.dart';
import 'package:room_sharing/Views/list_widgets.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class ConversationPage extends StatefulWidget {
  static final String routeName = '/ConversationPageRoute';

  const ConversationPage({Key? key}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppBarText(text: 'SammyBoy'),
        ),
        body: Column(
          children: [

            Expanded(child: ListView.builder(

                itemCount: 4,
                itemBuilder: (context,index){
              return MessageListTile();
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
