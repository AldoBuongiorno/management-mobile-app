import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/navigation/team_page.dart';
import 'commonElements/carousel_item.dart';
import 'commonElements/project_items.dart';
import 'navigation/add_page.dart';
import 'data/project_list.dart';
import './navigation/project_page.dart';

import './main.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [
    HomePageScreen(),
    const ProjectScreen(), //in navigation/project_page.dart
    const AddPage(), //in navigation/add_page.dart
    TeamScreen(), //in navigation/team_page.dart
    const Center(child: Text('Statistiche')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(56, 0, 0, 0),
        ),
      ),
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: Group21App.navigationBarTheme, //in main.dart
        child: ClipRect(
          //I'm using BackdropFilter for the blurring effect
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20.0,
              sigmaY: 20.0,
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
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.white
                    ),
                    selectedIcon: Icon(Icons.home),
                    label: ''
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.map_outlined,
                      color: Colors.white
                    ),
                    selectedIcon: Icon(Icons.map),
                    label: ''
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.add_outlined,
                      color: Colors.white),
                      selectedIcon: Icon(Icons.add),
                      label: ''
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.group_outlined,
                      color: Colors.white),
                      selectedIcon: Icon(Icons.group),
                      label: ''
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.add_chart_outlined,
                      color: Colors.white),
                      selectedIcon: Icon(Icons.add_chart),
                      label: ''
                  ),
                ],
              ),
            )
          )
        )
      )
    );
  }
}

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.amber,
        body: SingleChildScrollView(
            child: Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 20
                        : 100),
            child: const Row(children: [
              Text("Progetti recenti",
                  style: TextStyle(
                      fontFamily: 'SamsungSharpSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromARGB(255, 0, 0, 0)))
            ])),
        const SizedBox(height: 10),
        addCarouselIfNotEmpty(
            ProjectList.projectsList
                .where((element) => element.isActive())
                .toList(),
            context),
        const SizedBox(
          height: 20,
        ),
        Container(
            margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 20
                        : 100),
            child: const Row(children: [
              Text("Team recenti",
                  style: TextStyle(
                      fontFamily: 'SamsungSharpSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromARGB(255, 0, 0, 0)))
            ])),
        const SizedBox(height: 10),
        Container(
            margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 20
                        : 100),
            child: addTeamsIfNotEmpty(ProjectList.teamsList, context))
      ],
    )));
  }
}

Widget addCarouselIfNotEmpty(List testList, context) {
  if (ProjectList.projectsList.isEmpty) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: MediaQuery.of(context).orientation == Orientation.portrait
              ? 20
              : 100),
      child: const Text('Non ci sono progetti recenti.'),
    );
  } else {
    return CarouselSlider.builder(
      itemCount: ProjectList.projectsList
                  .where((element) => element.isActive())
                  .toList()
                  .length <
              ProjectList.projectOnHomepageNumber
          ? ProjectList.projectsList
              .where((element) => element.isActive())
              .toList()
              .length
          : ProjectList.projectOnHomepageNumber,
      itemBuilder: (context, index, realIndex) {
        //final urlImage = testList[index];
        ProjectItem testItem = testList[index];
        return buildCarousel(index, testItem);
      },
      options: CarouselOptions(height: 200),
    );
  }
}

Widget addTeamsIfNotEmpty(List testList, context) {
  if (testList.isEmpty) {
    return Container(
        alignment: Alignment.centerLeft,
        child: const Text('Non ci sono team recenti.'));
  } else {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: ProjectList.teamsList.length
                     <
                ProjectList.teamOnHomepageNumber
            ? ProjectList.teamsList.length
            : ProjectList.projectOnHomepageNumber,
        itemBuilder: (context, index) {
          return ExpandableTeamTile(ProjectList.membersList, index);
        });
  }
}
