// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';

class CalendarMonth extends StatefulWidget {
  final int monthIndex;
  final List<DateTime> bookedDates;

  const CalendarMonth(
      {Key? key, required this.monthIndex, required this.bookedDates})
      : super(key: key);

  @override
  _CalendarMonthState createState() => _CalendarMonthState();
}

class _CalendarMonthState extends State<CalendarMonth> {
  late List<MonthTile> _monthTiles;
  late int _currentMonthInt;

  late int _currentYearInt;

  void _setupMonthTiles() {
    setState(() {
      _monthTiles = [];
      int daysInMonth = AppConstants.daysInMonths[_currentMonthInt]!;
      DateTime firstDayMonth = DateTime(_currentYearInt, _currentMonthInt, 1);
      int firstWeekdayOfMonth = firstDayMonth.weekday;
      if (firstWeekdayOfMonth != 7) {
        for (int i = 0; i < firstWeekdayOfMonth; i++) {
          _monthTiles.add(MonthTile(dateTime: null));
        }
      }

      for (int i = 1; i <= daysInMonth; i++) {
        DateTime date = DateTime(_currentYearInt, _currentMonthInt, i);

        _monthTiles.add(MonthTile(dateTime: date));
      }
    });
  }

  @override
  void initState() {
    _currentMonthInt = (DateTime.now().month + widget.monthIndex) % 12;
    if (_currentMonthInt == 0) {
      _currentMonthInt = 12;
    }
    _currentYearInt = DateTime.now().year;
    if (_currentMonthInt < DateTime.now().month) {
      _currentYearInt += 1;
    }

    _setupMonthTiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
              '${AppConstants.monthDict[_currentMonthInt]!} - $_currentYearInt'),
        ),
        GridView.builder(
            itemCount: _monthTiles.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, childAspectRatio: 1 / 1),
            itemBuilder: (context, index) {
              MonthTile monthTile = _monthTiles[index];
              if (widget.bookedDates.contains(monthTile.dateTime)) {
                return MaterialButton(
                  onPressed: null,
                  child: monthTile,
                  disabledColor: Colors.redAccent,
                );
              }
              return MaterialButton(onPressed: () {}, child: monthTile);
            })
      ],
    );
  }
}

class MonthTile extends StatelessWidget {
  final DateTime? dateTime;

  const MonthTile({Key? key, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(dateTime == null ? "" : dateTime!.day.toString());
  }
}
