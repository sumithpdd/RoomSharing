// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Screens/guest_home_page.dart';
import 'package:room_sharing/Screens/host_home_page.dart';
import 'package:room_sharing/Screens/login_page.dart';
import 'package:room_sharing/Screens/personal_info_page.dart';
import 'package:room_sharing/Screens/view_profile_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _hostingTile = 'Host Dashboard';

  void _logout() {
    Navigator.pushNamed(context, LoginPage.routeName);
  }

  @override
  void initState() {
    if (AppConstants.currentUser.isHost) {
      if (AppConstants.currentUser.isCurrentlyHosting) {
        _hostingTile = "Guest Dashboard";
      } else {
        _hostingTile = "Host Dashboard";
      }
    } else {
      _hostingTile = "Become a host";
    }

    super.initState();
  }

  void _changeHosting() {
    if (AppConstants.currentUser.isHost) {
      if (AppConstants.currentUser.isCurrentlyHosting) {
        AppConstants.currentUser.isCurrentlyHosting = false;
        Navigator.pushNamed(context, GuestHomePage.routeName);
      } else {
        AppConstants.currentUser.isCurrentlyHosting = true;
        Navigator.pushNamed(context, HostHomePage.routeName);
      }
    } else {
      AppConstants.currentUser.becomeHost().whenComplete(() {
        AppConstants.currentUser.isCurrentlyHosting = true;
        Navigator.pushNamed(context, HostHomePage.routeName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewProfilePage(
                          contact:
                              AppConstants.currentUser.createContactFromUser(),
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width / 9.5,
                    child: CircleAvatar(
                      backgroundImage: AppConstants.currentUser.displayImage,
                      radius: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        AppConstants.currentUser.getFullName(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      AutoSizeText(
                        AppConstants.currentUser.email,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              MaterialButton(
                height: MediaQuery.of(context).size.height / 9.0,
                onPressed: () {
                  Navigator.pushNamed(context, PersonalInfoPage.routeName);
                },
                child: AccountPageListViewItem(
                  text: 'Personal Information',
                  iconData: Icons.person,
                ),
              ),
              MaterialButton(
                height: MediaQuery.of(context).size.height / 9.0,
                onPressed: _changeHosting,
                child: AccountPageListViewItem(
                  text: _hostingTile,
                  iconData: Icons.hotel,
                ),
              ),
              MaterialButton(
                height: MediaQuery.of(context).size.height / 9.0,
                onPressed: _logout,
                child: AccountPageListViewItem(
                  text: 'Logout',
                  iconData: Icons.logout,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AccountPageListViewItem extends StatelessWidget {
  final String text;
  final IconData iconData;

  const AccountPageListViewItem(
      {Key? key, required this.text, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      leading: Text(
        text,
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.normal),
      ),
      trailing: Icon(
        iconData,
        size: 35.0,
      ),
    );
  }
}
