// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Models/dummy_data.dart';
import 'package:room_sharing/Models/user_model.dart' as app_user;
import 'package:room_sharing/Screens/guest_home_page.dart';

import 'signup_page.dart';
import 'package:room_sharing/Models/user_model.dart' as app_user;

class LoginPage extends StatefulWidget {
  static const String routeName = '/loginPageRoute';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signup() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      AppConstants.currentUser = app_user.User();
      AppConstants.currentUser.email = email;
      AppConstants.currentUser.password = password;
      Navigator.pushNamed(context, SignupPage.routeName);
    }
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((firebaseUser) {
        String userId = firebaseUser.user!.uid;
        AppConstants.currentUser = app_user.User(id: userId);
        AppConstants.currentUser
            .getPersonalInfoFromFirestore()
            .whenComplete(() {
          Navigator.pushNamed(context, GuestHomePage.routeName);
        });

        //fetch rest of user info
        // DummyData.populateFields();
        // AppConstants.currentUser = DummyData.users[1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 0),
          child: Column(
            children: [
              Text(
                'Welcome to \n ${AppConstants.appName}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Username/email'),
                      style: TextStyle(fontSize: 25.0),
                      validator: (text) {
                        if (!text!.contains('@')) {
                          return 'Please enter a vaild email';
                        }
                        return null;
                      },
                      controller: _emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      style: TextStyle(fontSize: 25.0),
                      obscureText: true,
                      validator: (text) {
                        if (text!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      controller: _passwordController,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: MaterialButton(
                  onPressed: _login,
                  child: Text(
                    'Login',
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
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: MaterialButton(
                  onPressed: _signup,
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  color: Colors.grey,
                  height: MediaQuery.of(context).size.height / 12,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
