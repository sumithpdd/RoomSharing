// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Models/conversation_model.dart';
import 'package:room_sharing/Models/message_model.dart';
import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Models/review_model.dart';
import 'package:room_sharing/Screens/view_profile_page.dart';

import 'rating_widget.dart';

class ReviewListTile extends StatefulWidget {
  final Review review;
  const ReviewListTile({Key? key, required this.review}) : super(key: key);


  @override
  _ReviewListTileState createState() => _ReviewListTileState();
}

class _ReviewListTileState extends State<ReviewListTile> {
  late Review _review;
  @override
  void initState() {
    _review = widget.review;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkResponse(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewProfilePage(
                      contact:
                      _review.contact,
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage: _review.contact.displayImage,
                radius: MediaQuery.of(context).size.width / 15,
              ),
            ),
              Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: AutoSizeText(
                _review.contact.firstName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            StarRating(
                editable: false,
                initialRating: _review.rating,
                ratingSize: RatingSize.medium),
          ],
        ),
          Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 15),
          child: AutoSizeText(
            _review.text,
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}

class ConversationListTile extends StatefulWidget {
  final Conversation conversation;
    const ConversationListTile({Key? key,required this.conversation}) : super(key: key);

  @override
  _ConversationListTileState createState() => _ConversationListTileState();
}

class _ConversationListTileState extends State<ConversationListTile> {
  late Conversation _conversation ;
  @override
  void initState() {
    _conversation = widget.conversation;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewProfilePage(
                contact:
                _conversation.otherContact,
              ),
            ),
          );
        },
        child: CircleAvatar(
          backgroundImage: _conversation.otherContact.displayImage,
          radius: MediaQuery.of(context).size.width / 14.0,
        ),
      ),
      title: Text(
        _conversation.otherContact.firstName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.5),
      ),
      subtitle: Text(
        _conversation.getLastMessageText(),
        style: TextStyle(fontSize: 20),
      ),
      trailing: Text(
        _conversation.getLastMessageDateTime(),
        style: TextStyle(fontSize: 15),
      ),
      contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
    );
  }
}

class MessageListTile extends StatelessWidget {
  final Message message;

  const MessageListTile({Key? key,required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(message.sender.firstName == AppConstants.currentUser.firstName){
      return Padding(
        padding: const EdgeInsets.fromLTRB(35, 15, 15, 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          message.text,
                          textWidthBasis: TextWidthBasis.parent,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            message.getMessageDateTime(),
                            style: TextStyle(fontSize: 15.0),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewProfilePage(
                      contact:
                      AppConstants.currentUser.createContactFromUser(),
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage: AppConstants.currentUser.displayImage,
                radius: MediaQuery.of(context).size.width / 20,
              ),
            ),
          ],
        ),
      );
    }
    else{

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 35, 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewProfilePage(
                    contact:message.sender,
                  ),
                ),
              );
            },
            child: CircleAvatar(
              backgroundImage:message.sender.displayImage,
              radius: MediaQuery.of(context).size.width / 20,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        message.text,
                        textWidthBasis: TextWidthBasis.parent,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          message.getMessageDateTime(),
                          style: TextStyle(fontSize: 15.0),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }}
}

class MyPostingListTile extends StatefulWidget {
  final Posting posting;
  const MyPostingListTile({Key? key,required this.posting}) : super(key: key);

  @override
  _MyPostingListTileState createState() => _MyPostingListTileState();
}

class _MyPostingListTileState extends State<MyPostingListTile> {
  late Posting _posting;
  @override
  void initState() {
    _posting = widget.posting;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15.0),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: AutoSizeText(
          _posting.name,
          maxLines: 2,
          minFontSize: 20,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      trailing: AspectRatio(
        aspectRatio: 3 / 2,
        child: Image(
          image: _posting.displayImages.first,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

class CreatePostingListTile extends StatelessWidget {
  const CreatePostingListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.add),
          ),
          Text(
            'Create a posting',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          )
        ],
      ),
    );
  }
}
