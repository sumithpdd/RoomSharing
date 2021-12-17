// ignore_for_file: prefer_const_constructors, prefer_const_declarations, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:room_sharing/Models/app_constants.dart';

import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Models/review_model.dart';
import 'package:room_sharing/Screens/book_posting_page.dart';
import 'package:room_sharing/Screens/view_profile_page.dart';
import 'package:room_sharing/Views/form_widgets.dart';
import 'package:room_sharing/Views/list_widgets.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class ViewPostingPage extends StatefulWidget {
  static final String routeName = '/ViewPostingPageRoute';
  final Posting posting;

  const ViewPostingPage({Key? key, required this.posting}) : super(key: key);

  @override
  _ViewPostingPageState createState() => _ViewPostingPageState();
}

class _ViewPostingPageState extends State<ViewPostingPage> {
  late Posting _posting;

  // final List<String> _amenities = [
  //   'Hair dryer',
  //   'Dishwasher',
  //   'Iron',
  //   'Wifi',
  //   'GYM'
  // ];
  // final LatLng _aptLatLong = LatLng(51.5063836, -0.0745941);
  // late Completer<GoogleMapController> _completer;

  @override
  void initState() {
    _posting = widget.posting;
    _posting.getAllImagesFromStorage().whenComplete(() {
      setState(() {});
    });
    _posting.getHostFromFirestrore().whenComplete(() {
      setState(() {});
    });
    // _completer = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppBarText(text: 'Posting Information'),
          actions: [
            IconButton(
                onPressed: () {
                  AppConstants.currentUser.addSavedPosting(_posting);
                },
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 3 / 2,
                child: PageView.builder(
                    itemCount: _posting.displayImages.length,
                    itemBuilder: (context, index) {
                      MemoryImage currentImage = _posting.displayImages[index];
                      return Image(
                        image: currentImage,
                        fit: BoxFit.fill,
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: AutoSizeText(
                                _posting.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 5.0),
                            //   child: Text(
                            //     "",
                            //     style: TextStyle(fontSize: 20.0),
                            //   ),
                            // ),
                          ],
                        ),
                        Column(
                          children: [
                            MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookPostingPage(
                                        posting: _posting,
                                      ),
                                    ),
                                  );
                                },
                                color: Colors.redAccent,
                                child: Text(
                                  'Book Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            Text(
                              "\$${_posting.price} / night",
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.75,
                            child: AutoSizeText(
                              _posting.description,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              maxLines: 5,
                              minFontSize: 15.0,
                              maxFontSize: 20.0,
                            ),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width / 12.5,
                                backgroundColor: Colors.black,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewProfilePage(
                                            contact: _posting.host!),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundImage:
                                        _posting.host!.displayImage,
                                    radius:
                                        MediaQuery.of(context).size.width / 13,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  _posting.host!.firstName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          PostingInfoTile(
                              icondata: Icons.home,
                              category: _posting.type,
                              categoryInfo: '${_posting.getNumGuests()} guest'),
                          PostingInfoTile(
                              icondata: Icons.hotel,
                              category: 'Beds',
                              categoryInfo: _posting.getBedroomText()),
                          PostingInfoTile(
                              icondata: Icons.wc,
                              category: 'Bath',
                              categoryInfo: _posting.getBathroomText())
                        ],
                      ),
                    ),
                    Text(
                      "Amenities",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 4 / 1,
                        children:
                            List.generate(_posting.amenities.length, (index) {
                          return Text(
                            _posting.amenities[index],
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          );
                        }),
                      ),
                    ),
                    Text(
                      'The Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                      child: Text(
                        _posting.getFullAddress(),
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Text('map')
                          // GoogleMap(
                          //   onMapCreated: (controller) {
                          //     _completer.complete(controller);
                          //   },
                          //   mapType: MapType.normal,
                          //   initialCameraPosition: CameraPosition(
                          //     target: _aptLatLong,
                          //     zoom: 14,
                          //   ),
                          //   markers: <Marker>{
                          //     Marker(
                          //         markerId: MarkerId('Apartment location'),
                          //         position: _aptLatLong,
                          //         icon: BitmapDescriptor.defaultMarker)
                          //   },
                          // ),
                          ),
                    ),
                    Text(
                      'Reviews',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ReviewForm(
                        posting: _posting,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('postings/${_posting.id}/reviews')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshots) {
                              switch (snapshots.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );

                                default:
                                  return ListView.builder(
                                    itemCount: snapshots.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot snapshot =
                                          snapshots.data!.docs[index];

                                      Review currentReview = Review();
                                      currentReview
                                          .getReviewInfoFromFirestore(snapshot);

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: ReviewListTile(
                                          review: currentReview,
                                        ),
                                      );
                                    },
                                  );
                              }
                            })),
                  ],
                ),
              ),

              //ListView.builder(itemBuilder: itemBuilder)
            ],
          ),
        ));
  }
}

class PostingInfoTile extends StatelessWidget {
  final IconData icondata;
  final String category;
  final String categoryInfo;

  const PostingInfoTile(
      {Key? key,
      required this.icondata,
      required this.category,
      required this.categoryInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          icondata,
          size: 30.0,
        ),
        title: Text(
          category,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        subtitle: Text(
          categoryInfo,
          style: TextStyle(
            fontSize: 20,
          ),
        ));
  }
}
