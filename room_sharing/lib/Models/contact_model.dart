import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'user_model.dart';

class Contact {
  String id;
  late String firstName;
  late String lastName;
  late MemoryImage? displayImage;

  Contact({
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.displayImage,
  });

  String getFullName() {
    return firstName + " " + lastName;
  }

  User createUserFromContact() {
    return User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        displayImage: displayImage);
  }

  Future<void> getContactInfoFromFirestore() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    firstName = snapshot['firstName'] ?? "";
    lastName = snapshot['lastName'] ?? "";
  }

  Future<MemoryImage> getImageFromStorage() async {
    final String imagePath = "userImages/$id/profile_pic.jpg";
    final imageData = await FirebaseStorage.instance
        .ref()
        .child(imagePath)
        .getData(1024 * 1024);

    displayImage = MemoryImage(imageData!);
    return displayImage!;
  }
}
