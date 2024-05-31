import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'package:flutter_application/navigation/team_page.dart';
import 'commonElements/carousel_item.dart';
import 'navigation/add_page.dart';
import 'data/project_list.dart';
import './navigation/project_page.dart';
import './main.dart';
import 'package:flutter_application/classes/all.dart';
import './navigation/stats_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [
    const HomePageScreen(),
    const ProjectScreen(), //in navigation/project_page.dart
    const AddPage(), //in navigation/add_page.dart
    const TeamScreen(), //in navigation/team_page.dart
    const StatsPage(),  //in navigation/stats_page.dart
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

  Future<List<Project>> _loadProjectsOrderByLastModified() async {
    return await DatabaseHelper.instance.getActiveProjectsOrderedByLastModified(); 
  }

  Future<List<Team>> _TeamsOrderedByMemberCount() async {
    return await DatabaseHelper.instance.getTeamsOrderedByMemberCount(); 
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_loadProjectsOrderByLastModified() , _TeamsOrderedByMemberCount()]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
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
            child: Row(children: [
              CustomHeadingTitle(titleText: 'Progetti recenti'),
            ])),
        const SizedBox(height: 10),
        addCarouselIfNotEmpty(
            snapshot.data?[0] as List<Project>,
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
            child: Row(children: [
              CustomHeadingTitle(titleText: 'Team recenti'),
            ])),
        const SizedBox(height: 10),
        Container(
            margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 20
                        : 100),
            child: addTeamsIfNotEmpty(snapshot.data?[1] as List<Team>, context))
      ],
    )));
        
     
        }
      },
    );
  }


    
 

Widget addCarouselIfNotEmpty(List testList, BuildContext context) {
  if (testList.isEmpty) {
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
      itemCount: testList.length /*ProjectList.projectsList
                  .where((element) => element.isActive())
                  .toList()
                  .length <
              ProjectList.projectOnHomepageNumber
          ? ProjectList.projectsList
              .where((element) => element.isActive())
              .toList()
              .length
          : ProjectList.projectOnHomepageNumber*/,
      itemBuilder: (context, index, realIndex) {
        //final urlImage = testList[index];
        Project testItem = testList[index];
        return buildCarousel(index, testItem);
      },
      options: CarouselOptions(height: 200),
    );
  }
}

Widget addTeamsIfNotEmpty(List testList, BuildContext context) {
  if (testList.isEmpty) {
    return Container(
        alignment: Alignment.centerLeft,
        child: const Text('Non ci sono team recenti.'));
  } else {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: testList.length/*testlistProjectList.teamsList.length
                     <
                ProjectList.teamOnHomepageNumber
            ? ProjectList.teamsList.length
            : ProjectList.projectOnHomepageNumber*/,
        itemBuilder: (context, index)  {
          return FutureBuilder<List<Member>>(
            future: DatabaseHelper.instance.getMembersByTeam(testList[index].getName()),
            builder: (context, membersSnapshot) {
                if (membersSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Visualizza un indicatore di caricamento durante il caricamento dei membri del team
                } else if (membersSnapshot.hasError) {
                  return Text('Errore: ${membersSnapshot.error}'); // Gestisci eventuali errori durante il caricamento dei membri del team
                } else {
                  return ExpandableTeamTile(testList[index].getName(),membersSnapshot.data!, index);
                }
              },

          );
        
        
        
        
        
        
        
        
        });
  }
}


}