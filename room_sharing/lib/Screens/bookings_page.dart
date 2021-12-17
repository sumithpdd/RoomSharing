// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Views/calendar_widgets.dart';
import 'package:room_sharing/Views/list_widgets.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  List<DateTime> _bookedDates = [];

  late List<DateTime> _allBookedDates = [];

  late final List<DateTime> _selectedDates = [];
  void _selectDate(DateTime dateTime) {}
  Posting? _selectedPosting;

  List<DateTime> _getSelectedDates() {
    return _selectedDates;
  }

  void _selectAPosting(Posting posting) {
    setState(() {
      _selectedPosting = posting;
      _bookedDates = posting.getAllBookedDates();
    });
  }

  void _clearSelectedPosting() {
    setState(() {
      _bookedDates = _allBookedDates;
      _selectedPosting = null;
    });
  }

  @override
  void initState() {
    _bookedDates = AppConstants.currentUser.getAllBookedDates();
    _allBookedDates = AppConstants.currentUser.getAllBookedDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('Sun'),
                  Text('Mon'),
                  Text('Tue'),
                  Text('Wed'),
                  Text('Thu'),
                  Text('Fri'),
                  Text('Sat'),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.9,
              child: PageView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return CalendarMonth(
                    monthIndex: index,
                    bookedDates: _bookedDates,
                    selectDate: _selectDate,
                    getSelectedDates: _getSelectedDates,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 25.0, 0.0, 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter by Posting',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  MaterialButton(
                    onPressed: _clearSelectedPosting,
                    child: Text(
                      'Reset',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: AppConstants.currentUser.myPostings.length,
                  itemBuilder: (context, index) {
                    Posting currentPosting =
                        AppConstants.currentUser.myPostings[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: InkResponse(
                        onTap: () {
                          _selectAPosting(
                              AppConstants.currentUser.myPostings[index]);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: _selectedPosting ==
                                          AppConstants
                                              .currentUser.myPostings[index]
                                      ? Colors.yellow
                                      : Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: MyPostingListTile(
                              posting: currentPosting,
                            )),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
