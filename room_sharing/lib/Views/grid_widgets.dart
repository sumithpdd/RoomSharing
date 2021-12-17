// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:room_sharing/Models/booking_model.dart';
import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Views/rating_widget.dart';

class PostingGridTile extends StatefulWidget {
  final Posting posting;

  const PostingGridTile({Key? key, required this.posting}) : super(key: key);

  @override
  _PostingGridTileState createState() => _PostingGridTileState();
}

class _PostingGridTileState extends State<PostingGridTile> {
  late Posting _posting;
  double _rating = 2.5;
  @override
  void initState() {
    _posting = widget.posting;
    _posting.getFirstImageFromStorage().whenComplete(() {
      setState(() {});
    });
    _rating = _posting.getCurrentRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 3 / 2,
          child: (_posting.displayImages.isEmpty
              ? Container()
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _posting.displayImages.first,
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
        ),
        AutoSizeText(
          '${_posting.type}  - ${_posting.city} , ${_posting.country}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        AutoSizeText(
          _posting.name,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Text(
          '\$${_posting.price}  / night',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        StarRating(
            editable: false,
            ratingValue: _rating,
            ratingSize: RatingSize.small,
            onRatingUpdated: (rating) {
              setState(() {
                _rating = rating;
              });
            }),
      ],
    );
  }
}

class TripGridTile extends StatefulWidget {
  final Booking booking;
  const TripGridTile({Key? key, required this.booking}) : super(key: key);

  @override
  _TripGridTileState createState() => _TripGridTileState();
}

class _TripGridTileState extends State<TripGridTile> {
  late Booking _booking;
  @override
  void initState() {
    _booking = widget.booking;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 3 / 2,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: _booking.posting!.displayImages.first,
              fit: BoxFit.fill,
            )),
          ),
        ),
        AutoSizeText(
          _booking.posting!.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        AutoSizeText(
          "${_booking.posting!.city} , ${_booking.posting!.country}",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          '\$${_booking.posting!.price} / night',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Text(
          '${_booking.getFirstDate()} - ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _booking.getLastDate(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
