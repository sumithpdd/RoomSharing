// ignore_for_file: prefer_const_constructors, prefer_const_declarations, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:room_sharing/Screens/book_posting_page.dart';

import 'package:room_sharing/Screens/view_profile_page.dart';
import 'package:room_sharing/Views/form_widgets.dart';
import 'package:room_sharing/Views/list_widgets.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class ViewPostingPage extends StatefulWidget {
  static final String routeName = '/ViewPostingPageRoute';

  const ViewPostingPage({Key? key}) : super(key: key);

  @override
  _ViewPostingPageState createState() => _ViewPostingPageState();
}

class _ViewPostingPageState extends State<ViewPostingPage> {
  final List<String> _amenities = [
    'Hair dryer',
    'Dishwasher',
    'Iron',
    'Wifi',
    'GYM'
  ];
  final LatLng _aptLatLong = LatLng(51.5063836, -0.0745941);
  late Completer<GoogleMapController> _completer;

  @override
  void initState() {
    _completer = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppBarText(text: 'Posting Information'),
          actions: [
            IconButton(
                onPressed: () {},
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
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Image(
                        image: AssetImage('assets/images/apartment.jpg'),
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
                                "Apatment - Tower Bridge",
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
                                  Navigator.pushNamed(context, BookPostingPage.routeName);


                                },
                                color: Colors.redAccent,
                                child: Text(
                                  'Book Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            Text(
                              "\$120 / night",
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
                              "A quite and cozy place in the heart of the city. easy to get to wheresoever you want to go",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                              maxLines: 5,
                              minFontSize: 18.0,
                              maxFontSize: 22.0,
                            ),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width / 12.5,
                                backgroundColor: Colors.black,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, ViewProfilePage.routeName);
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/sumith2020.jpg'),
                                    radius:
                                        MediaQuery.of(context).size.width / 13,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  'Sumith ',
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
                              category: 'Apartment',
                              categoryInfo: '2 guest'),
                          PostingInfoTile(
                              icondata: Icons.hotel,
                              category: '1 Bedroom',
                              categoryInfo: 'i King'),
                          PostingInfoTile(
                              icondata: Icons.wc,
                              category: '2 Bath',
                              categoryInfo: '1 shower room')
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
                        children: List.generate(_amenities.length, (index) {
                          return Text(
                            _amenities[index],
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
                        'St Katharine\'s Way, London E1W 1LD',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: GoogleMap(
                          onMapCreated: (controller) {
                            _completer.complete(controller);
                          },
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: _aptLatLong,
                            zoom: 14,
                          ),
                          markers: <Marker>{
                            Marker(
                                markerId: MarkerId('Apartment location'),
                                position: _aptLatLong,
                                icon: BitmapDescriptor.defaultMarker)
                          },
                        ),
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
                      child: ReviewForm(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: ReviewListTile(),
                          );
                        },
                      ),
                    ),
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
