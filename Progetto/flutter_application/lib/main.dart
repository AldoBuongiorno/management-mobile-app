import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/data/project_list.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:css_colors/css_colors.dart';
import './homepage.dart';


void main() { 
  runApp(Group21App()); 
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); }



class Group21App extends StatelessWidget {
  const Group21App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProjectList();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gruppo 21',
      theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(selectionHandleColor: Colors.pink, selectionColor: Colors.pinkAccent, cursorColor: Colors.pink),
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: AppBarTheme(backgroundColor: Colors.transparent, toolbarHeight: 50),
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Color.fromARGB(255, 0, 0, 0),
              displayColor: Color.fromARGB(255, 0, 0, 0),
              fontFamily: 'Poppins')),
              
      home: HomePage(),
    );
  }
}

