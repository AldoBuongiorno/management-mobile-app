import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import 'package:flutter_application/data/project_list.dart';
import '../../commonElements/blurred_box.dart';
import 'package:flutter_application/classes/all.dart';

List<ProjectItem> list = ProjectList().getList();

Widget projectView(int index, context) {
  return Container(
    margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: MediaQuery.of(context).orientation == Orientation.portrait
            ? 20
            : 100),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeadingTitle(titleText: "Descrizione"),
        Container( 
          padding: EdgeInsets.all(10),
          child:
          Expanded( child: Row(
          children: [ Expanded( child: Text(list[index].description) ) ]),),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        ),
      ],
    ),
  );
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
        )),
        child: Scaffold(
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
            appBar: PreferredSize(
              child: Container(
                  child: BlurredBox(
                borderRadius: 0,
                sigma: 5,
                child: AppBar(
                  foregroundColor: Colors.white,
                  //titleTextStyle: TextStyle(color: Colors.white),
                  backgroundColor: const Color.fromARGB(100, 0, 0, 0),
                  title: Text(list[index].name),
                ),
              )),
              preferredSize: Size(MediaQuery.of(context).size.width, 55),
            ),
            body: SingleChildScrollView(child: projectView(index, context))));
  }
}
