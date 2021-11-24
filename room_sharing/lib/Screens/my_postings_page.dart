// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Screens/create_posting_page.dart';
import 'package:room_sharing/Views/list_widgets.dart';

class MyPostingsPage extends StatefulWidget {
  const MyPostingsPage({Key? key}) : super(key: key);

  @override
  _MyPostingsPageState createState() => _MyPostingsPageState();
}

class _MyPostingsPageState extends State<MyPostingsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: ListView.builder(
          itemCount: AppConstants.currentUser.myPostings.length +1,
          itemBuilder: (context, index) {

            return Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePostingPage(
                        posting: (index ==
                                AppConstants.currentUser.myPostings.length)
                            ? null
                            : AppConstants.currentUser.myPostings[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(5)),
                  child: index == AppConstants.currentUser.myPostings.length
                      ? CreatePostingListTile()
                      : MyPostingListTile(
                          posting: AppConstants.currentUser.myPostings[index],
                        ),
                ),
              ),
            );
          }),
    );
  }
}
