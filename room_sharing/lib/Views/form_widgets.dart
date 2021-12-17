// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Models/user_model.dart';
import 'package:room_sharing/Views/rating_widget.dart';

class ReviewForm extends StatefulWidget {
  final Posting? posting;
  final User? user;
  const ReviewForm({Key? key, this.posting, this.user}) : super(key: key);

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final TextEditingController _controller = TextEditingController();
  double _rating = 2.5;

  void _submitReview() {
    if (widget.posting == null) {
      widget.user!.postNewReview(_controller.text, _rating).whenComplete(() {
        setState(() {
          _controller.text = "";
        });
      });
    } else {
      widget.posting!.postNewReview(_controller.text, _rating).whenComplete(() {
        setState(() {
          _controller.text = "";
        });
      });
    }
  }

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
                  controller: _controller,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: StarRating(
                    editable: true,
                    ratingValue: _rating,
                    ratingSize: RatingSize.large,
                    onRatingUpdated: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: _submitReview,
            color: Colors.blue,
            child: Text('Submit'),
          ),
        ]),
      ),
    );
  }
}
