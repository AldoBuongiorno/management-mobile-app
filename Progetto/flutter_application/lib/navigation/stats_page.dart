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
          //Prende il primo elemento della lista e lo trasforma in statistica generali, 
          //invece dovrebbe crearne una nuova completamente. Forse da aggiungere una nuova lista
          //oltre a quella dichiarata in precedenza che acquisice quella di prova.
          if (index == 0) {
            return Card(
              child: ListTile(
                title: const Text('Statstiche generali'), 
                subtitle: Text(list[index].status),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateTotalStatsProjectScreen(projects: list),
                    ),
                  );
                },
              ),
            );
          }
          else{
            return Card(
              child: ListTile(
                title: Text(list[--index].name), //decrementa l'indice per accedere al primo elemento
                subtitle: Text(list[index].status),
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
          Text('Nome del progetto: ${widget.project.name}'),
          Text('Stato del progetto: ${widget.project.status}'),
          Text('Nome del team: ${widget.project.team.teamName}'),
          ...widget.project.team.members.asMap().entries.map((entry) {
            int idx = entry.key;
            Member member = entry.value;
            return Text('Membro ${idx + 1}: ${member.name}');
          }),
        ],
      ),
    );
  }
}

class CreateTotalStatsProjectScreen extends StatefulWidget {
  final List<ProjectItem> projects;
  const CreateTotalStatsProjectScreen({super.key, required this.projects});

  @override
  State<CreateTotalStatsProjectScreen> createState() => _CreateTotalStatsProjectScreenState();
}

class _CreateTotalStatsProjectScreenState extends State<CreateTotalStatsProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiche complessive'),
      ),
      body: Column(
        children: <Widget>[
          ...widget.projects.map((project) {
            return Column(
              children: <Widget>[
                Text('Nome del progetto: ${project.name}'),
                Text('Stato del progetto: ${project.status}'),
                Text('Nome del team: ${project.team.teamName}'),
                ...project.team.members.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Member member = entry.value;
                  return Text('Membro ${idx + 1}: ${member.name}');
                }),
              ],
            );
          }),
        ],
      ),
    );
  }
}