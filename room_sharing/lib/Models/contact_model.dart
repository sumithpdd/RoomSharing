import 'package:flutter/material.dart';

import 'user_model.dart';

class Contact {
  late String firstName;
  late String lastName;
  late String imagePath;
  late AssetImage displayImage;

  Contact({this.firstName = "", this.lastName = "", this.imagePath = ""}) {
    displayImage = AssetImage(imagePath);
  }

  String getFullName() {
    return firstName + " " + lastName;
  }

  User createUserFromContact() {
    return User(firstName: firstName, lastName: lastName, imagePath: imagePath);
  }
}
