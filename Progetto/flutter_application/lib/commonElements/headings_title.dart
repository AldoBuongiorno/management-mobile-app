import 'package:flutter/material.dart';

class CustomHeadingTitle extends StatelessWidget{
  const CustomHeadingTitle({super.key, required this.titleText}); //Aggiunto const 
  final String titleText; //Eliminato late
  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'VisbyCF',
        fontWeight: FontWeight.bold,
        fontSize: 22
      ),
    );
  }
}