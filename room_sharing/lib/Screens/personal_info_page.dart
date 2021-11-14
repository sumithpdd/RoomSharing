// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:room_sharing/Screens/guest_home_page.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class PersonalInfoPage extends StatefulWidget {
  static final String routeName = '/PersonalInfoPageRoute';

  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  void _saveInfo() {
    Navigator.pushNamed(context, GuestHomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Personal Information'),
        actions: [
          IconButton(
            onPressed: _saveInfo,
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Column(
              children: [
                Form(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'First name'),
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Last name'),
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'City'),
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Country'),
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Bio'),
                        style: TextStyle(fontSize: 25.0),
                        maxLines: 3,
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: MaterialButton(
                    onPressed: () {},
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: MediaQuery.of(context).size.width / 4.8,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/sumith2020.jpg'),
                        radius: MediaQuery.of(context).size.width / 5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
