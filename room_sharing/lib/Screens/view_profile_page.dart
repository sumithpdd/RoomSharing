// ignore_for_file: prefer_const_constructors, prefer_const_declarations, prefer_const_literals_to_create_immutables, unused_import

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Models/contact_model.dart';
import 'package:room_sharing/Models/dummy_data.dart';
import 'package:room_sharing/Models/review_model.dart';
import 'package:room_sharing/Models/user_model.dart';
import 'package:room_sharing/Views/form_widgets.dart';
import 'package:room_sharing/Views/list_widgets.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class ViewProfilePage extends StatefulWidget {
  static final String routeName = '/ViewProfilePageRoute';
  final Contact contact;

  const ViewProfilePage({Key? key, required this.contact}) : super(key: key);

  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  late User _user;

  @override
  void initState() {
    if (widget.contact.id == AppConstants.currentUser.id) {
      _user = AppConstants.currentUser;
    } else {
      _user = widget.contact.createUserFromContact();
      _user.getUserInfoFromFirestore().whenComplete(() {
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'View Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 50, 35, 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 5,
                    child: AutoSizeText(
                      'Hi my name is ${_user.getFullName()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width / 9.5,
                    child: CircleAvatar(
                      backgroundImage: _user.displayImage,
                      radius: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'About me:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: AutoSizeText(
                  _user.bio,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Location:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Icon(Icons.home),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: AutoSizeText(
                        'Lives in ${_user.city} , ${_user.country}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Reviews:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ReviewForm(
                  user: _user,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users/${_user.id}/reviews')
                        .orderBy('dateTime', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                      switch (snapshots.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );

                        default:
                          return ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              DocumentSnapshot snapshot =
                                  snapshots.data!.docs[index];

                              Review currentReview = Review();
                              currentReview
                                  .getReviewInfoFromFirestore(snapshot);

                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10.0),
                                child: ReviewListTile(
                                  review: currentReview,
                                ),
                              );
                            },
                          );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
