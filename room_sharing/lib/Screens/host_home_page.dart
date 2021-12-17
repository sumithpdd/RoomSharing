// ignore_for_file: prefer_const_constructors, prefer_const_declarations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Screens/account_page.dart';
import 'package:room_sharing/Screens/bookings_page.dart';
import 'package:room_sharing/Screens/inbox_page.dart';
import 'package:room_sharing/Screens/my_postings_page.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class HostHomePage extends StatefulWidget {
  static final String routeName = '/HostHomePageRoute';
  final int? index;

  const HostHomePage({Key? key, this.index}) : super(key: key);

  @override
  _HostHomePageState createState() => _HostHomePageState();
}

class _HostHomePageState extends State<HostHomePage> {
  int _selectedIndex = 3;
  @override
  void initState() {
    _selectedIndex = widget.index ?? 3;
    super.initState();
  }

  final List<String> _pageTitles = [
    'Booking',
    'My Postings',
    'Inbox',
    'Profile'
  ];
  final List<Widget> _pages = [
    BookingsPage(),
    MyPostingsPage(),
    InboxPage(),
    AccountPage(),
  ];

  BottomNavigationBarItem _buildNavigationItem(
      int index, IconData iconData, String text) {
    return BottomNavigationBarItem(
        icon: Icon(
          iconData,
          color: AppConstants.nonSelectedIconColor,
        ),
        activeIcon: Icon(
          iconData,
          color: AppConstants.selectedIconColor,
        ),
        title: Text(
          text,
          style: TextStyle(
              color: _selectedIndex == index
                  ? AppConstants.selectedIconColor
                  : AppConstants.nonSelectedIconColor),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarText(
          text: _pageTitles[_selectedIndex],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildNavigationItem(0, Icons.calendar_today, _pageTitles[0]),
          _buildNavigationItem(1, Icons.home, _pageTitles[1]),
          _buildNavigationItem(2, Icons.message, _pageTitles[2]),
          _buildNavigationItem(3, Icons.person_outline, _pageTitles[3]),
        ],
      ),
    );
  }
}
