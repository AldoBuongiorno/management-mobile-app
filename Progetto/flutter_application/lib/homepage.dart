import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/navigation/team_page.dart';
import './carouselItem.dart';
import './projectItems.dart';
import 'navigation/add_page.dart';
import './projectList/projectList.dart';
import './navigation/project_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [
    HomePageScreen(),
    ProjectScreen(),    //in navigation/project_page.dart
    AddPage(),          //in navigation/add_page.dart
    TeamScreen(),       //in navigation/team_page.dart
    Center(child: Text('Statistiche')),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 232, 232, 232),
            Color.fromARGB(255, 0, 183, 255),
            Color.fromARGB(255, 0, 183, 255),
            Color.fromARGB(255, 255, 0, 115),
            Color.fromARGB(255, 255, 0, 115),
            Colors.yellow
          ],
          stops: [0.79, 0.79, 0.865, 0.865, 0.94, 0.94],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          //stops: [0.6, 0.7, 0.8, 0.9]
        )),
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color.fromARGB(56, 0, 0, 0),
              ),
            ),
            body: screens[index],
            bottomNavigationBar: NavigationBarTheme(
                data: const NavigationBarThemeData(
                  height: 55,
                  indicatorColor: Color.fromARGB(255, 235, 235, 235),
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  backgroundColor: Color.fromARGB(56, 0, 0, 0),
                ),
                child: ClipRect(
                    //I'm using BackdropFilter for the blurring effect
                    child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0,
                        ),
                        child: Opacity(
                          //you can change the opacity to whatever suits you best
                          opacity: 1,
                          child: NavigationBar(
                            //animationDuration: Duration(seconds: 1),

                            selectedIndex: index,
                            onDestinationSelected: (index) =>
                                setState(() => this.index = index),
                            destinations: const [
                              NavigationDestination(
                                  icon: Icon(Icons.home_outlined,
                                      color: Colors.white),
                                  selectedIcon: Icon(Icons.home),
                                  label: ''),
                              NavigationDestination(
                                  icon: Icon(Icons.map_outlined,
                                      color: Colors.white),
                                  selectedIcon: Icon(Icons.map),
                                  label: ''),
                              NavigationDestination(
                                  icon: Icon(Icons.add_outlined,
                                      color: Colors.white),
                                  selectedIcon: Icon(Icons.add),
                                  label: ''),
                              NavigationDestination(
                                  icon: Icon(Icons.group_outlined,
                                      color: Colors.white),
                                  selectedIcon: Icon(Icons.group),
                                  label: ''),
                              NavigationDestination(
                                  icon: Icon(Icons.add_chart_outlined,
                                      color: Colors.white),
                                  selectedIcon: Icon(Icons.add_chart),
                                  label: ''),
                            ],
                          ),
                        ))))));
  }
}

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.amber,
        body: SingleChildScrollView(
            child: Container(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(children: [
            SizedBox(width: 55),
            Text("Progetti recenti",
                style: TextStyle(
                    fontFamily: 'SamsungSharpSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color.fromARGB(255, 0, 0, 0)))
          ]),
          const SizedBox(height: 10),
          addCarouselIfNotEmpty(ProjectList().getList()),
          /*CarouselSlider.builder(
              itemCount: testList.length,
              itemBuilder: (context, index, realIndex) {
                //final urlImage = testList[index];
                ProjectItem testItem = testList[index];
                return buildCarousel(index, testItem);
              },
              options: CarouselOptions(height: 200)),*/
          const SizedBox(
            height: 20,
          ),
          const Row(children: [
            SizedBox(width: 55),
            Text("Team recenti",
                style: TextStyle(
                    fontFamily: 'SamsungSharpSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color.fromARGB(255, 0, 0, 0)))
          ]),
          const SizedBox(height: 10),
          addTeamsIfNotEmpty(ProjectList().getList()),
          
        ],
      ),
    )));
  }
}

Widget addCarouselIfNotEmpty(List testList) {
  if (testList.isEmpty) {
    return Container(
      child: Text('Non ci sono progetti.'),
      alignment: Alignment(0, 0),
      height: 75,
    );
  } else {
    return CarouselSlider.builder(
        itemCount: testList.length,
        itemBuilder: (context, index, realIndex) {
          //final urlImage = testList[index];
          ProjectItem testItem = testList[index];
          return buildCarousel(index, testItem);
        },
        options: CarouselOptions(height: 200), );
  }
}

Widget addTeamsIfNotEmpty(List testList) {
  if (testList.isEmpty) {
    return Container(
      child: Text('Non ci sono team.'),
      alignment: Alignment(0, 0),
      height: 75,
    );
  } else {
    return CarouselSlider.builder(
        itemCount: testList.length,
        itemBuilder: (context, index, realIndex) {
          //final urlImage = testList[index];
          ProjectItem testItem = testList[index];
          return buildCarousel(index, testItem);
        },
        options: CarouselOptions(height: 200));
  }
}
