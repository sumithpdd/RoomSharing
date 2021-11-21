// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:room_sharing/Screens/view_posting_page.dart';
import 'package:room_sharing/Views/grid_widgets.dart';

class MyPostingsPage extends StatefulWidget {
  const MyPostingsPage({Key? key}) : super(key: key);

  @override
  _MyPostingsPageState createState() => _MyPostingsPageState();
}

class _MyPostingsPageState extends State<MyPostingsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('My Postings Page'));
  }
}
