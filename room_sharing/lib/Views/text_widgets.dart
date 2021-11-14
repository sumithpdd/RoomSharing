
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppBarText extends StatelessWidget {
 final String text;
  const AppBarText({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 20.0),
    );
  }
}
