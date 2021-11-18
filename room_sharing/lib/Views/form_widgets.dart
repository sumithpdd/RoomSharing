// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:room_sharing/Models/app_constants.dart';

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
                  child: RatingBar(
                    initialRating: 3,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30.0,
                    glowColor: AppConstants.selectedIconColor,
                    unratedColor: AppConstants.nonSelectedGreyIconColor,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    onRatingUpdate: (rating) {
                      setState(() {
                        // _rating = rating;
                      });
                    },
                    ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star,
                        color: AppConstants.selectedIconColor,
                        size: 5,
                      ),
                      half: const Icon(
                        Icons.star,
                        color: AppConstants.selectedIconColor,
                        size: 5,
                      ),
                      empty: const Icon(
                        Icons.star,
                        color: AppConstants.nonSelectedGreyIconColor,
                        size: 5,
                      ),
                    ),
                  ),
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
