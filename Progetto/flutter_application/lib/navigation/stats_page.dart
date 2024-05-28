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
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text('Statistiche progetti', 
                  style: TextStyle(
                    fontFamily: 'SamsungSharpSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color.fromARGB(255, 0, 0, 0)
                  )
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          SliverPadding(
            padding: getResponsivePadding(context), //in responsive_padding.dart
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == 0) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: ListTile(
                        title: const Text('Statstiche generali'), 
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
                      margin: const EdgeInsets.only(bottom: 15),
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
                },
                childCount: list.length,
              ),
            ),
          ),
        ],
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
        title: const Text('Statistiche progetto',
          style: TextStyle(
            fontFamily: 'SamsungSharpSans',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color.fromARGB(255, 0, 0, 0)
          )
        ),
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