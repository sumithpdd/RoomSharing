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

  @override
  void initState() {
    _posting = widget.posting;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppBarText(text: 'Book a Posting'),
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
                child: PageView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return CalendarMonth(
                      monthIndex: index,
                      bookedDates: _posting.getAllBookedDates(),
                    );
                  },
                ),
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
