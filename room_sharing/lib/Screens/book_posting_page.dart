// ignore_for_file: prefer_const_constructors, prefer_const_declarations, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Views/calendar_widgets.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class BookPostingPage extends StatefulWidget {
  static final String routeName = '/BookPostingPageRoute';
  final Posting posting;

  const BookPostingPage({Key? key, required this.posting}) : super(key: key);

  @override
  _BookPostingPageState createState() => _BookPostingPageState();
}

class _BookPostingPageState extends State<BookPostingPage> {
  late Posting _posting;

  late List<CalendarMonth> _calendarWidgets = [];
  late List<DateTime> _bookedDates = [];

  void _buildCalendarWidgets() {
    _calendarWidgets = [];
    for (int i = 0; i < 12; i++) {
      _calendarWidgets
          .add(CalendarMonth(monthIndex: i, bookedDates: _bookedDates));
    }
    setState(() {});
  }

  void _loadBookedDates() {
    _bookedDates = [];
    _posting.getAllBookingsFromFirestore().whenComplete(() {
      _bookedDates = _posting.getAllBookedDates();
      _buildCalendarWidgets();
    });
  }

  @override
  void initState() {
    _posting = widget.posting;
    _loadBookedDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppBarText(text: 'Book ${_posting.name}'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Sun'),
                  Text('Mon'),
                  Text('Tue'),
                  Text('Wed'),
                  Text('Thu'),
                  Text('Fri'),
                  Text('Sat'),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                child: (_calendarWidgets.isEmpty
                    ? Container()
                    : PageView.builder(
                        itemCount: _calendarWidgets.length,
                        itemBuilder: (context, index) {
                          return _calendarWidgets[index];
                        },
                      )),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text('Book Now!'),
                minWidth: double.infinity,
                height: MediaQuery.of(context).size.height / 14,
                color: Colors.blue,
              )
            ],
          ),
        ));
  }
}
