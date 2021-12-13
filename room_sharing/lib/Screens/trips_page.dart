// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Models/booking_model.dart';
import 'package:room_sharing/Views/grid_widgets.dart';

import 'view_posting_page.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upcoming Trips',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    Booking currentBooking =
                        AppConstants.currentUser.getUpcomingTrips()[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: InkResponse(
                          enableFeedback: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPostingPage(
                                  posting: currentBooking.posting!,
                                ),
                              ),
                            );
                          },
                          child: TripGridTile(
                            booking: currentBooking,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: AppConstants.currentUser.getUpcomingTrips().length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                ),
              ),
            ),
            Text(
              'Previous Trips',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    Booking currentBooking =
                        AppConstants.currentUser.getPreviousTrips()[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: InkResponse(
                          enableFeedback: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPostingPage(
                                  posting: currentBooking.posting!,
                                ),
                              ),
                            );
                          },
                          child: TripGridTile(
                            booking: currentBooking,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: AppConstants.currentUser.getPreviousTrips().length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
