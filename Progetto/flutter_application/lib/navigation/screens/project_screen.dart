import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/projectList/projectList.dart';
import '../../commonElements/blurredBox.dart';
import '../../projectItems.dart';
List<ProjectItem> list = ProjectList().getList();

Widget projectView(int index) {
  return Container(child: Column(children: [
      Text("Descrizione"),
      Container(child: Text(list[index].description)),
      


  ],),);
}

class ProjectRoute extends StatelessWidget {
  int index;
  ProjectRoute(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 232, 232, 232), //255, 232
                Color.fromARGB(255, 0, 183, 255),
                Color.fromARGB(255, 0, 183, 255),
                Color.fromARGB(255, 255, 0, 115),
                Color.fromARGB(255, 255, 0, 115),
                Colors.yellow
              ],
              stops: [0.79, 0.79, 0.865, 0.865, 0.94, 0.94],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,

              //stops: [0.6, 0.7, 0.8, 0.9]
            )),
            child: Scaffold(
              backgroundColor: Color.fromARGB(0, 0, 0, 0),
              appBar: PreferredSize(
                child: Container(
                  child: BlurredBox( borderRadius: 0, sigma: 5,
                    child: AppBar(
                      foregroundColor: Colors.white,
                      //titleTextStyle: TextStyle(color: Colors.white),
                      backgroundColor: const Color.fromARGB(100, 0, 0, 0),
                      title: Text(list[index].name),
                    ),
                  )),
                
                preferredSize: Size(MediaQuery.of(context).size.width, 55),
              ),
              body: SingleChildScrollView(child: projectView(index)
            )));
  
  }
  
}