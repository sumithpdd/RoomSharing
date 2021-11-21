// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:room_sharing/Screens/view_profile_page.dart';

import 'rating_widget.dart';

class ReviewListTile extends StatefulWidget {
  const ReviewListTile({Key? key}) : super(key: key);

  @override
  _ReviewListTileState createState() => _ReviewListTileState();
}

class _ReviewListTileState extends State<ReviewListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage('assets/images/sumith2020.jpg'),
              radius: MediaQuery.of(context).size.width / 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: AutoSizeText(
                'Sumith',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            StarRating(
                editable: false,
                initialRating: 2.5,
                ratingSize: RatingSize.medium),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 15),
          child: AutoSizeText(
            'Great stay!, very helpful. Would definitely recommend the soup',
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}

class ConversationListTile extends StatefulWidget {
  const ConversationListTile({Key? key}) : super(key: key);

  @override
  _ConversationListTileState createState() => _ConversationListTileState();
}

class _ConversationListTileState extends State<ConversationListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ViewProfilePage.routeName);
        },
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/defaultAvatar.jpg'),
          radius: MediaQuery.of(context).size.width / 14.0,
        ),
      ),
      title: Text(
        'Sammy Boy',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.5),
      ),
      subtitle: Text(
        'Is it Available?',
        style: TextStyle(fontSize: 20),
      ),
      trailing: Text(
        'Dec 30',
        style: TextStyle(fontSize: 15),
      ),
      contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
    );
  }
}

class MessageListTile extends StatelessWidget {
  const MessageListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        'this is a long long message and this will be over flowing into multiple lines',
                        textWidthBasis: TextWidthBasis.parent,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'December 1',
                          style: TextStyle(fontSize: 15.0),
                        ))
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ViewProfilePage.routeName);
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/defaultAvatar.jpg'),
              radius: MediaQuery.of(context).size.width / 20,
            ),
          ),
        ],
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.fromLTRB(15, 15, 35, 15.0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.end,
    //     children: [
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.pushNamed(context, ViewProfilePage.routeName);
    //         },
    //         child: CircleAvatar(
    //           backgroundImage: AssetImage('assets/images/defaultAvatar.jpg'),
    //           radius: MediaQuery.of(context).size.width / 20,
    //         ),
    //       ),
    //       Flexible(
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 10.0),
    //           child: Container(
    //             padding: EdgeInsets.all(15.0),
    //             decoration: BoxDecoration(
    //                 color: Colors.yellow,
    //                 borderRadius: BorderRadius.circular(10)),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.max,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(bottom: 10.0),
    //                   child: Text(
    //                     'this is a long long message and this will be over flowing into multiple lines',
    //                     textWidthBasis: TextWidthBasis.parent,
    //                     style: TextStyle(fontSize: 20.0),
    //                   ),
    //                 ),
    //                 Align(
    //                     alignment: Alignment.bottomRight,
    //                     child: Text(
    //                       'December 1',
    //                       style: TextStyle(fontSize: 15.0),
    //                     ))
    //               ],
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

class MyPostingListTile extends StatefulWidget {
  const MyPostingListTile({Key? key}) : super(key: key);

  @override
  _MyPostingListTileState createState() => _MyPostingListTileState();
}

class _MyPostingListTileState extends State<MyPostingListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15.0),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: AutoSizeText(
          'Awesome Apartment',
          maxLines: 2,
          minFontSize: 20,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      trailing: AspectRatio(
        aspectRatio: 3 / 2,
        child: Image(
          image: AssetImage('assets/images/apartment.jpg'),
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
