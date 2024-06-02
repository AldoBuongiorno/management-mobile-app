import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';
import 'package:flutter_application/commonElements/responsive_padding.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'package:flutter_application/navigation/routes/create_project_route.dart';
import '../../commonElements/blurred_box.dart';
import '../../commonElements/headings_title.dart';
import '../../commonElements/selectable_thumbnail_grid.dart';
import '../../commonElements/tasks_checkbox_view.dart';
import '../../data/project_list.dart';

// int selectedTeam = 0;
// List<Task> tasks = [];

class EditTeamScreen extends StatefulWidget {
  const EditTeamScreen({super.key, required this.team});

  final Team team;

  @override
  State<EditTeamScreen> createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  late TextEditingController teamNameController;
  // late TextEditingController projectDescriptionController;
  // TextEditingController taskInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    teamNameController = TextEditingController(text: widget.team.getName());
    // teamDescriptionController = TextEditingController(text: widget.project.description);
  }

  @override
  void dispose() {
    teamNameController.dispose();
    super.dispose();
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
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(100, 0, 0, 0),
              title: Text('Modifica ${widget.team.name}'),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: getResponsivePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    CustomHeadingTitle(titleText: "Nome"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BlurredBox(
                    borderRadius: BorderRadius.circular(30),
                    sigma: 15,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: teamNameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 15,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(100, 0, 0, 0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: widget.team.name,
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 192, 192, 192),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    CustomHeadingTitle(titleText: "Membri"),
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BlurredBox(
                    borderRadius: BorderRadius.circular(10),
                    sigma: 15,
                    child: FutureBuilder<List<Member>>(
                      future: _loadMembersByTeam(widget.team.getName()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('Matricola:'),
                                            Text('Nome:'),
                                            Text('Cognome:'),
                                            Text('Ruolo:'),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              snapshot.data![index]
                                                  .getCode()
                                                  .toString(),
                                            ),
                                            Text(
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              snapshot.data![index]
                                                  .getMemberName(),
                                            ),
                                            Text(
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              snapshot.data![index]
                                                  .getMemberSurname(),
                                            ),
                                            Text(
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              snapshot.data![index]
                                                  .getMemberRole(),
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
                ElevatedButton(
                  onPressed: () {
                    DatabaseHelper.instance.updateTeamName(
                      widget.team.getName(),
                      teamNameController.text,
                    );
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Successo!'),
                        content: Text(
                          'Il team "${widget.team.name}" è stato modificato correttamente.',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Ok'),
                            child: const Text('Ok'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.save),
                      SizedBox(width: 5),
                      Text("Modifica team"),
                    ],
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




