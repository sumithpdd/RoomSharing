// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:room_sharing/Views/rating_widget.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({Key? key}) : super(key: key);

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Enter review text'),
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0, bottom: 10.0),
                  child: StarRating(editable:true,initialRating: 2.5,ratingSize: RatingSize.large,),
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {},
            color: Colors.blue,
            child: Text('Submit'),
          ),
        ]),
      ),
    );
  }
}
