import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:room_sharing/Models/app_constants.dart';

enum RatingSize { small, medium, large }

class StarRating extends StatefulWidget {
  final bool editable;
  final RatingSize ratingSize;
  final double ratingValue;
  final Function onRatingUpdated;

  StarRating({
    Key? key,
    required this.editable,
    required this.ratingSize,
    required this.ratingValue,
    required this.onRatingUpdated,
  }) : super(key: key);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    double ratingItemSize = 15;

    switch (widget.ratingSize) {
      case RatingSize.large:
        ratingItemSize = 30.0;
        break;
      case RatingSize.medium:
        ratingItemSize = 20.0;
        break;
      case RatingSize.small:
        ratingItemSize = 15.0;
        break;
    }

    return RatingBar(
      initialRating: widget.ratingValue,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: ratingItemSize,
      ignoreGestures: !widget.editable,
      glowColor: AppConstants.selectedIconColor,
      unratedColor: AppConstants.nonSelectedGreyIconColor,
      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
      onRatingUpdate: (rating) {
        widget.onRatingUpdated(rating);
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
    );
  }
}
