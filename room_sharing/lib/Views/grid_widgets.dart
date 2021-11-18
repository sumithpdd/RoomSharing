// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:room_sharing/Views/rating_widget.dart';

class PostingGridTile extends StatefulWidget {
  const PostingGridTile({Key? key}) : super(key: key);

  @override
  _PostingGridTileState createState() => _PostingGridTileState();
}

class _PostingGridTileState extends State<PostingGridTile> {
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
          'Best view, new decor',
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
        StarRating(
            editable: false, initialRating: 3.5, ratingSize: RatingSize.medium),
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
