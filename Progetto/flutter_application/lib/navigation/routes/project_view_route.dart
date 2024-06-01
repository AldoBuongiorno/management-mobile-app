import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import 'package:flutter_application/data/project_list.dart';
import '../../commonElements/blurred_box.dart';
import 'package:flutter_application/classes/all.dart';

import 'edit_project_route.dart';

//List<ProjectItem> list = ProjectList().getList();

Widget projectView(Project project, context) {
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child:
          Expanded( child: Row(
          children: [ Expanded( child: Text(project.description) ) ]),),
        ),
      ],
    ),
  );
}

class ProjectRoute extends StatefulWidget {
  Project project;
  ProjectRoute(this.project);

  @override
  State<ProjectRoute> createState() => _ProjectRouteState();
}

class _ProjectRouteState extends State<ProjectRoute> {




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
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            appBar: PreferredSize(
              
              preferredSize: Size(MediaQuery.of(context).size.width, 55),
              child: BlurredBox(
                              borderRadius: BorderRadius.zero,
                              sigma: 5,
                              child: AppBar(
                                actions: [
                                  IconButton(onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProjectScreen(
                                          project: widget.project,
                                        ))), icon: const Icon(Icons.settings))
                                ],
              foregroundColor: Colors.white,
              //titleTextStyle: TextStyle(color: Colors.white),
              backgroundColor: const Color.fromARGB(100, 0, 0, 0),
              title: Text(widget.project.name),
                              ),
                            ),
            ),
            body: SingleChildScrollView(child: projectView(widget.project, context))));
  }
}
