import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';
import 'package:flutter_application/commonElements/responsive_padding.dart';
import 'package:flutter_application/data/database_helper.dart';
import '../../commonElements/blurred_box.dart';
import '../../commonElements/headings_title.dart';
import '../../commonElements/selectable_team_list.dart';
import '../../commonElements/selectable_thumbnail_grid.dart';
import '../../commonElements/tasks_checkbox_view.dart';
import '../../data/thumbnail.dart';

int selectedTeam = 0;
List<Task> tasks = [];

class EditProjectScreen extends StatefulWidget {
  const EditProjectScreen({super.key, required this.project});

  final Project project;

  @override
  State<EditProjectScreen> createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  late TextEditingController projectNameController;
  late TextEditingController projectDescriptionController;
  TextEditingController taskInputController = TextEditingController();
  late FutureBuilder dontSetStatePlease; late SelectableTeamsList chips;
  late SelectableThumbnailGrid grid;

  @override
  void initState() {
    super.initState();
    projectNameController = TextEditingController(text: widget.project.name);
    projectDescriptionController = TextEditingController(text: widget.project.description);

  grid = SelectableThumbnailGrid(
      selectedThumbnail: Thumbnail.projectThumbnails.indexOf(widget.project.thumbnail),
      list: Thumbnail.projectThumbnails
    );
    dontSetStatePlease = FutureBuilder(
                    future: DatabaseHelper.instance.getTeams(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        chips = SelectableTeamsList(
                          teamsList: snapshot.data!,
                          selectedTeam: snapshot.data!.indexOf(widget.project.team!),
                        );
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [chips]),
                        );
                      }
                    }
                  );

  }

  @override
  void dispose() {
    projectNameController.dispose();
    super.dispose();
  }

  Future<TasksCheckboxView> _loadTasks() async {
    List<Task> tasks = await DatabaseHelper.instance
      .getTasksByProjectName(widget.project.name);
    return TasksCheckboxView(tasks: tasks);
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
            Colors.yellow
          ],
          stops: [0.79, 0.79, 0.865, 0.865, 0.94, 0.94],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        )
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
              title: Text('Modifica ${widget.project.name}')
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics().applyTo(const AlwaysScrollableScrollPhysics()),
          child: Container(
            margin: getResponsivePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                Row(children: [CustomHeadingTitle(titleText: "Nome")]),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10, 
                    horizontal: 0
                  ),
                  child: BlurredBox(
                    borderRadius: BorderRadius.circular(30),
                    sigma: 15,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: projectNameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, 
                          horizontal: 15
                        ),
                        filled: true,
                        fillColor:const Color.fromARGB(100, 0, 0, 0),
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: widget.project.name,
                        hintStyle: const TextStyle(color: Color.fromARGB(255, 192, 192, 192))
                      ),
                    )
                  ),
                ),
                const SizedBox(height: 5),
                Row(children: [CustomHeadingTitle(titleText: "Descrizione")]),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10, 
                    horizontal: 0
                  ),
                  child: BlurredBox(
                    borderRadius: BorderRadius.circular(10),
                    sigma: 15,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      maxLines: 5,
                      controller: projectDescriptionController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15, 
                          horizontal: 15
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(100, 0, 0, 0),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText:'Questo progetto si pone l\' obiettivo di...',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 192, 192, 192))
                      ),
                    )
                  ),
                ),
                const SizedBox(height: 5),
                Row(children: [CustomHeadingTitle(titleText: "Team")]),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: dontSetStatePlease,  
                ),
                const SizedBox(height: 5),
                Row(children: [CustomHeadingTitle(titleText: "Copertina")]),
                grid,
                Row(children: [CustomHeadingTitle(titleText: "Task")]),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10, 
                    horizontal: 0
                  ),
                  child: BlurredBox(
                    borderRadius: BorderRadius.circular(10),
                    sigma: 15,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: taskInputController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (taskInputController.text.isNotEmpty) {                                    
                              DatabaseHelper.instance.insertTask(
                                Task(
                                  name: taskInputController.text,
                                  project: widget.project
                                )
                              );  
                            }
                            taskInputController.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.add,color: Colors.white)
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, 
                          horizontal: 15
                        ),
                        filled: true,
                        fillColor:const Color.fromARGB(100, 0, 0, 0),
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Inserisci una task',
                        hintStyle: const TextStyle(color: Color.fromARGB(255, 192, 192, 192))
                      ),
                    )
                  ),
                ),
                FutureBuilder<TasksCheckboxView>(
                  future: _loadTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Errore: ${snapshot.error}'));
                    } else {
                      return snapshot.data!;
                    }
                  },
                ),
                Row(
                  children: [
                    const Icon(Icons.auto_awesome),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        'Le task aggiunte o rimosse vengono salvate automaticamente.',
                        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
                      )
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.pink
                      ),
                      onPressed: () async {
                        List<Team> teamsList = await DatabaseHelper.instance.getTeams();
                        String oldName = widget.project.name;
                        !(projectNameController.text.isEmpty || projectDescriptionController.text.isEmpty || 
                          projectNameController.text == '' || projectDescriptionController.text == '') ? {
                            widget.project.name = projectNameController.text,
                            widget.project.description = projectDescriptionController.text,
                            widget.project.team = teamsList[chips.selectedTeam],

                            DatabaseHelper.instance.updateProjectName(oldName,projectNameController.text),
                            DatabaseHelper.instance.updateProjectTeam(
                              projectNameController.text,
                              teamsList[chips.selectedTeam].name
                            ),
                            DatabaseHelper.instance.updateDescription(
                              projectNameController.text,
                              projectDescriptionController.text
                            ),
                            DatabaseHelper.instance.updateThumbnail(
                              projectNameController.text,
                              Thumbnail.projectThumbnails[grid.selectedThumbnail].assetName
                            ),
                            DatabaseHelper.instance.updateTaskProject(oldName,projectNameController.text),
                            setState(() {}),

                            Navigator.of(context).pop(),
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                padding: EdgeInsets.zero,
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                content: Container(
                                  color: const Color.fromARGB(156, 0, 0, 0),
                                  child: BlurredBox(
                                    sigma: 20,
                                    borderRadius:BorderRadius.zero,
                                    child: const Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Text('Progetto modificato con successo!'),
                                        SizedBox(height: 10)
                                      ]
                                    )
                                  )
                                ),
                              )
                            )
                        } : {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Errore'),
                              content: const Text("Il campo nome e descrizione non possono essere vuoti."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Ok'),
                                  child: const Text('Ok'),
                                ),
                              ],
                            )
                          )
                        };
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.save),
                          SizedBox(width: 5),
                          Text("Modifica progetto")
                        ]
                      )
                    )
                  ]
                )
              ]
            )
          )
        )
      )
    );
  }
}
