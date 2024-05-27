import 'dart:ui';

import 'package:flutter/material.dart';
import 'routes/create_member_route.dart';
import 'routes/create_project_screen.dart';
import 'package:input_quantity/input_quantity.dart';
import '../data/project_list.dart';
import 'routes/create_team_route.dart';
import '../commonElements/responsive_padding.dart';
import 'package:flutter_application/classes/all.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

List<ProjectItem> list = ProjectList().testList; //utilizzo lista di prova
@override
class _StatsPageState extends State<StatsPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getResponsivePadding(context), //in responsive_padding.dart
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Card(
            child: ListTile(
              title: const Text('Statstiche generali'),
              // subtitle: Text(list[index].status),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateStatsProjectScreen(project: list[index]),
                  ),
                );
              },
            ),
          );
          }
          else{
            return Card(
              child: ListTile(
                title: Text(list[index].name),
                subtitle: Text(list[index].status),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CreateStatsProjectScreen(project: list[index]),
                  //   ),
                  // );
                },
              ),
            );
          }
        }
      ),
    );
  }
}

class CreateStatsProjectScreen extends StatefulWidget {
  final ProjectItem project;
  const CreateStatsProjectScreen({super.key, required this.project});

  @override
  State<CreateStatsProjectScreen> createState() => _CreateStatsProjectScreenState();
}

class _CreateStatsProjectScreenState extends State<CreateStatsProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiche progetto'),
      ),
      body: Column(
        children: <Widget>[
          // Text(widget.project.name),
          // Text(widget.project.status),
          // Text(widget.project.team.name),
          // Text(widget.project.team.members.toString()),
        ],
      ),
    );
  }
}