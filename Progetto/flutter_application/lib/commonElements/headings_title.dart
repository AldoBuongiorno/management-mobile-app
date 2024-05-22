import 'package:flutter/material.dart';

class CustomHeadingTitle extends StatelessWidget{
  CustomHeadingTitle({required this.titleText});
  late final String titleText;
  @override
  Widget build(BuildContext context) {
    return Text(
          titleText,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: 'SamsungSharpSans',
              fontWeight: FontWeight.bold,
              fontSize: 22),
        );
  }


}