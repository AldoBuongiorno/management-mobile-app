import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';
import 'package:flutter_application/commonElements/responsive_padding.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'package:flutter_application/navigation/routes/edit_team_route.dart';
import '../../commonElements/blurred_box.dart';
import '../../commonElements/headings_title.dart';

class TeamRoute extends StatefulWidget {
  const TeamRoute({super.key, required this.team});

  final Team team;

  @override
  _TeamRouteState createState() => _TeamRouteState();
}

class _TeamRouteState extends State<TeamRoute> {
  late Future<List<Member>> _membersFuture;

  @override
  void initState() {
    super.initState();
    _membersFuture = _loadMembersByTeam(widget.team.getName());
  }

  Future<List<Member>> _loadMembersByTeam(String team) async {
    final membersTeam = await DatabaseHelper.instance.getMembersByTeam(team);
    return membersTeam;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 232, 232, 232),
            Color.fromARGB(255, 0, 183, 255),
            Color.fromARGB(255, 0, 183, 255),
            Color.fromARGB(255, 255, 0, 115),
            Color.fromARGB(255, 255, 0, 115),
            Colors.yellow,
          ],
          stops: [0.79, 0.79, 0.865, 0.865, 0.94, 0.94],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 55),
          child: BlurredBox(
            borderRadius: BorderRadius.zero,
            sigma: 15,
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTeamScreen(
                        team: widget.team,
                      ),
                    ),
                  ).then((_) {
                    setState(() {
                      _membersFuture = _loadMembersByTeam(widget.team.getName());
                    });
                  }),
                  icon: const Icon(Icons.edit),
                ),
              ],
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(100, 0, 0, 0),
              title: Text(widget.team.name),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: getResponsivePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    CustomHeadingTitle(titleText: "Membri"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BlurredBox(
                    borderRadius: BorderRadius.circular(10),
                    sigma: 15,
                    child: FutureBuilder<List<Member>>(
                      future: _membersFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Errore: ${snapshot.error}'),
                          );
                        } else {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                  left: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('Matricola:'),
                                            Text('Nome:'),
                                            Text('Cognome:'),
                                            Text('Ruolo:'),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                              snapshot.data![index].getCode().toString(),
                                            ),
                                            Text(
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                              snapshot.data![index].getMemberName(),
                                            ),
                                            Text(
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                              snapshot.data![index].getMemberSurname(),
                                            ),
                                            Text(
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                              snapshot.data![index].getMemberRole(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
