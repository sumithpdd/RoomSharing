// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _posting = widget.posting;
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
              image: _posting.displayImages.first,
              fit: BoxFit.fill,
            )),
          ),
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
          initialRating: _posting.getCurrentRating(),
          ratingSize: RatingSize.small,
        ),
      ],
    );
  }
}

class TripGridTile extends StatefulWidget {
  const TripGridTile({Key? key}) : super(key: key);

  @override
  _TripGridTileState createState() => _TripGridTileState();
}

class _TripGridTileState extends State<TripGridTile> {
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
              image: AssetImage('assets/images/apartment.jpg'),
              fit: BoxFit.fill,
            )),
          ),
        ),
        AutoSizeText(
          'Apartment  - London tower bridge',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        AutoSizeText(
          'London, UK',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          '\$120 / night',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Text(
          '25 Dec 2021 - ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ' 05 Jan 2022',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
