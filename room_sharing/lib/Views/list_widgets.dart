import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:room_sharing/Models/app_constants.dart';

class ReviewListTile extends StatefulWidget {
  const ReviewListTile({Key? key}) : super(key: key);

  @override
  _ReviewListTileState createState() => _ReviewListTileState();
}

class _ReviewListTileState extends State<ReviewListTile> {
  late double _rating;

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
            RatingBar(
              initialRating: 3,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20.0,
              ignoreGestures: true,
              glowColor: AppConstants.selectedIconColor,
              unratedColor: AppConstants.nonSelectedGreyIconColor,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
              ratingWidget: RatingWidget(
                full: const Icon(
                  Icons.star,
                  color: AppConstants.selectedIconColor,size: 5,
                ),
                half: const Icon(
                  Icons.star,
                  color: AppConstants.selectedIconColor,size: 5,
                ),
                empty: const Icon(
                  Icons.star,
                  color: AppConstants.nonSelectedGreyIconColor,size: 5,
                ),
              ),
            )
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
