// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
              backgroundImage: const  AssetImage('assets/images/sumith2020.jpg'),
              radius: MediaQuery.of(context).size.width / 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: AutoSizeText(
                'Sumith',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            StarRating(editable: false,initialRating: 2.5,ratingSize: RatingSize.medium),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top:10.0,bottom:15),
          child: AutoSizeText(
              'Great stay!, very helpful. Would definitely recommend the soup',
            style: TextStyle( fontSize: 18),),
        )
      ],
    );
  }
}
