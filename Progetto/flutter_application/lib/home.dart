import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/navigation/teams_page.dart';
import 'navigation/add_page.dart';
import 'navigation/homepage.dart';
import 'navigation/projects_page.dart';
import './main.dart';
import './navigation/stats_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [
    HomePageScreen(), //in navigation/homepage.dart
    const ProjectScreen(), //in navigation/projects_page.dart
    const AddPage(), //in navigation/add_page.dart
    const TeamScreen(), //in navigation/teams_page.dart
    const StatsPage(), //in navigation/stats_page.dart
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle( //stile dell'area di sistema sopra l'applicazione
            statusBarColor: Color.fromARGB(56, 0, 0, 0),
          ),
        ),
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
            data: Group21App.navigationBarTheme, //in main.dart
            child: ClipRect( //serve per ritagliare il figlio in un rettangolo per garantire che l'effetto di sfocatura (BackdropFilter) venga applicato correttamente solo all'interno del rettangolo del widget.
                child: BackdropFilter(
                    filter: ImageFilter.blur( //sfocatura allo sfondo della navbar
                      sigmaX: 20.0,
                      sigmaY: 20.0,
                    ),
                    child: Opacity( //opacità della navbar
                      //you can change the opacity to whatever suits you best
                      opacity: 1,
                      child: NavigationBar(
                        //overlayColor: MaterialStateProperty.all<Color>(Colors.green),
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
                              icon:
                                  Icon(Icons.map_outlined, color: Colors.white),
                              selectedIcon: Icon(Icons.map),
                              label: ''),
                          NavigationDestination(
                              icon:
                                  Icon(Icons.settings_outlined, color: Colors.white),
                              selectedIcon: Icon(Icons.settings),
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
                    )))));
  }
}

