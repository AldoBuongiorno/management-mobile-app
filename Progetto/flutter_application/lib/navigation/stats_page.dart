import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/database_helper.dart';
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

Future<List<Member>> _loadMembers(String teamName) async {
  return await DatabaseHelper.instance.getMembersByTeam(teamName);
}

List<Project> list = ProjectList().getProjectsList(); //utilizzo lista di prova

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
                        color: Color.fromARGB(255, 0, 0, 0))),
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
                              builder: (context) =>
                                  CreateTotalStatsProjectScreen(projects: list),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: ListTile(
                        title: Text(list[--index]
                            .name), //decrementa l'indice per accedere al primo elemento
                        subtitle: Text(list[index].getStatus()!),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateStatsProjectScreen(
                                  project: list[index]),
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
  final Project project;
  const CreateStatsProjectScreen({super.key, required this.project});

  @override
  State<CreateStatsProjectScreen> createState() =>
      _CreateStatsProjectScreenState();
}

class _CreateStatsProjectScreenState extends State<CreateStatsProjectScreen> {
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
          child: ClipRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(100, 0, 0, 0),
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('Statistiche ${widget.project.name}'),
              ),
            ),
          )),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 350,
                minWidth: 350,
                minHeight: 250,
                maxHeight: 250,
              ),
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 11),
                    ),
                    Text('Nome del progetto: ${widget.project.name}'),
                    Text('Stato del progetto: ${widget.project.status}'),
                    Text('Nome del team: ${widget.project.team?.getName()}'),
                    FutureBuilder<List<Member>>(
                      future: _loadMembers(widget.project.team!.getName()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Errore: ${snapshot.error}');
                        } else {
                          return Column(
                            children:
                                snapshot.data!.asMap().entries.map((entry) {
                              int idx = entry.key;
                              Member member = entry.value;
                              return Text(
                                'Membro ${idx + 1}: ${member.name}',
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateTotalStatsProjectScreen extends StatefulWidget {
  final List<Project> projects;
  const CreateTotalStatsProjectScreen({super.key, required this.projects});

  @override
  State<CreateTotalStatsProjectScreen> createState() =>
      _CreateTotalStatsProjectScreenState();
}

class _CreateTotalStatsProjectScreenState
    extends State<CreateTotalStatsProjectScreen> {
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
          child: ClipRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(100, 0, 0, 0),
              title: const Text('Statistiche complessive'),
            ),
          )),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ...widget.projects.map((project) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 350,
                      minWidth: 350,
                      minHeight: 250,
                      maxHeight: 250,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Scrollbar(
                        thickness:
                            6.0, // adjust the thickness of the scrollbar as needed
                        radius: const Radius.circular(10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(bottom: 11),
                              ),
                              Text(
                                'Nome del progetto: ${project.name}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Stato del progetto: ${project.status}',
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Nome del team: ${project.team!.getName()}',
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              FutureBuilder<List<Member>>(
                                future: _loadMembers(project.team!.getName()),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Errore: ${snapshot.error}');
                                  } else {
                                    return Column(
                                      children: snapshot.data!
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        int idx = entry.key;
                                        Member member = entry.value;
                                        return Text(
                                          'Membro ${idx + 1}: ${member.name}',
                                          style: const TextStyle(fontSize: 16),
                                          textAlign: TextAlign.center,
                                        );
                                      }).toList(),
                                    );
                                  }
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 11),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
