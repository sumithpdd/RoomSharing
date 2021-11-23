// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Screens/guest_home_page.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class PersonalInfoPage extends StatefulWidget {
  static final String routeName = '/PersonalInfoPageRoute';

  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;
  late TextEditingController _bioController;

  @override
  void initState() {
    _firstNameController =
        TextEditingController(text: AppConstants.currentUser.firstName);
    _lastNameController =
        TextEditingController(text: AppConstants.currentUser.lastName);
    _emailController =
        TextEditingController(text: AppConstants.currentUser.email);
    _cityController =
        TextEditingController(text: AppConstants.currentUser.city);
    _countryController =
        TextEditingController(text: AppConstants.currentUser.country);
    _bioController = TextEditingController(text: AppConstants.currentUser.bio);

    super.initState();
  }

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
                        controller: _firstNameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Last name'),
                        style: TextStyle(fontSize: 25.0),
                        controller: _lastNameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        style: TextStyle(fontSize: 25.0),
                        enabled: false,
                        controller: _emailController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        style: TextStyle(fontSize: 25.0),
                        enabled: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'City'),
                        style: TextStyle(fontSize: 25.0),
                        controller: _cityController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Country'),
                        style: TextStyle(fontSize: 25.0),
                        controller: _countryController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Bio'),
                        style: TextStyle(fontSize: 25.0),
                        controller: _bioController,
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
                        backgroundImage: AppConstants.currentUser.displayImage,
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
