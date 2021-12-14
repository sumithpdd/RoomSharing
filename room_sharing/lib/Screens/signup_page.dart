// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Screens/guest_home_page.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class SignupPage extends StatefulWidget {
  static final String routeName = '/SignupPageRoute';

  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  XFile? _imageFile;

  void _chooseImage() async {
    ImagePicker imagePicker = ImagePicker();
    var imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  void _signup() {
    if (!_formKey.currentState!.validate() || _imageFile == null) {
      return;
    }

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: AppConstants.currentUser.email,
            password: AppConstants.currentUser.password)
        .then((firebaseuser) {
      String userId = firebaseuser.user!.uid;
      AppConstants.currentUser.id = userId;
      AppConstants.currentUser.firstName = _firstNameController.text;
      AppConstants.currentUser.lastName = _lastNameController.text;
      AppConstants.currentUser.city = _cityController.text;
      AppConstants.currentUser.country = _countryController.text;
      AppConstants.currentUser.bio = _bioController.text;

      AppConstants.currentUser.addUserToFirestore().whenComplete(() {
        //  File imageFile = File('assets/images/defaultAvatar.jpg');
        AppConstants.currentUser
            .addImageToFirestore(File(_imageFile!.path))
            .whenComplete(() {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: AppConstants.currentUser.email,
                  password: AppConstants.currentUser.password)
              .whenComplete(() {
            Navigator.pushNamed(context, GuestHomePage.routeName);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Sign Up'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
            child: Column(
              children: [
                Text(
                  'Please enter the following information:',
                  style: TextStyle(fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
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
                            return "Please enter a first name";
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
                            return "Please enter a last name";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
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
                            return "Please enter a valid city";
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
                            return "Please enter a valid Country";
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
                        maxLines: 3,
                        controller: _bioController,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                  ),
                  child: MaterialButton(
                    onPressed: _chooseImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: MediaQuery.of(context).size.width / 4.8,
                      child: (_imageFile == null)
                          ? Icon(Icons.add)
                          : CircleAvatar(
                              backgroundImage:
                                  FileImage(File(_imageFile!.path)),
                              radius: MediaQuery.of(context).size.width / 5,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: MaterialButton(
                    onPressed: _signup,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    color: Colors.blue,
                    height: MediaQuery.of(context).size.height / 12,
                    minWidth: double.infinity,
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
