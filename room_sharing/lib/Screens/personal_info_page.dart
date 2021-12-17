// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final _formKey = GlobalKey<FormState>();

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

  XFile? _newimageFile;

  void _chooseImage() async {
    ImagePicker imagePicker = ImagePicker();
    var imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _newimageFile = imageFile;
      });
    }
  }

  ImageProvider _getCircleAvatarImage() {
    if ((_newimageFile != null)) {
      return FileImage(File(_newimageFile!.path));
    } else {
      return AppConstants.currentUser.displayImage!;
    }
  }

  void _saveInfo() {
    if (_formKey.currentState!.validate()) {
      return;
    }
    AppConstants.currentUser.firstName = _firstNameController.text;
    AppConstants.currentUser.lastName = _lastNameController.text;
    AppConstants.currentUser.city = _cityController.text;
    AppConstants.currentUser.country = _countryController.text;
    AppConstants.currentUser.bio = _bioController.text;
    AppConstants.currentUser.updateUserInFirestore().whenComplete(() {});
    if (_newimageFile != null) {
      AppConstants.currentUser
          .addImageToFirestore(File(_newimageFile!.path))
          .whenComplete(() {
        Navigator.pushNamed(context, GuestHomePage.routeName);
      });
    } else {
      Navigator.pushNamed(context, GuestHomePage.routeName);
    }
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
                  key: _formKey,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'First name'),
                        style: TextStyle(fontSize: 25.0),
                        controller: _firstNameController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "please enter a valid first name";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Last name'),
                        style: TextStyle(fontSize: 25.0),
                        controller: _lastNameController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "please enter a valid last name";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
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
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "please enter a valid city";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Country'),
                        style: TextStyle(fontSize: 25.0),
                        controller: _countryController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "please enter a valid Country";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Bio'),
                        style: TextStyle(fontSize: 25.0),
                        controller: _bioController,
                        maxLines: 3,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "please enter a valid bio";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: MaterialButton(
                    onPressed: _chooseImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: MediaQuery.of(context).size.width / 4.8,
                      child: CircleAvatar(
                        backgroundImage: _getCircleAvatarImage(),
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
