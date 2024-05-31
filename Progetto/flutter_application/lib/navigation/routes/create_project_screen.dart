// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/blurred_box.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import 'package:flutter_application/data/database_helper.dart';
import '../../commonElements/selectable_thumbnail_grid.dart';
import '../../commonElements/tasks_checkbox_view.dart';
import '../../data/project_list.dart';
import '../../commonElements/headings_title.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_application/classes/all.dart';

int selectedTeam = 0;
List<Task> cTasks = [];


class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final projectNameController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  TextEditingController taskInputController = TextEditingController();

  @override
  void dispose() {
    projectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TasksCheckboxView taskCheckboxList = TasksCheckboxView(tasks: cTasks);
    SelectableThumbnailGrid grid = SelectableThumbnailGrid();
    Project projectItem;
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 20
                    : 100),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end ,children: [
          const SizedBox(height: 20),
          Row(children: [
            //SizedBox(width: 5),
            CustomHeadingTitle(titleText: "Nome"),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: BlurredBox(
                borderRadius: BorderRadius.circular(30),
                sigma: 15,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: projectNameController,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: Color.fromARGB(100, 0, 0, 0),
                      border: OutlineInputBorder(
                          //borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Inserisci il nome del progetto',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
                )),
          ),
          const SizedBox(height: 5),
          Row(children: [
            //SizedBox(width: 25),
            CustomHeadingTitle(titleText: "Descrizione"),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: BlurredBox(
                borderRadius: BorderRadius.circular(10),
                sigma: 15,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  maxLines: 5,
                  controller: projectDescriptionController,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: Color.fromARGB(100, 0, 0, 0),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Questo progetto si pone l\' obiettivo di...',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
                )),
          ),
          const SizedBox(height: 5),
          Row(children: [
            //SizedBox(width: 25),
            CustomHeadingTitle(titleText: "Team"),
                      ]),
          const SizedBox(height: 5),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    SelectableTeamsList(),




                  ])),
          const SizedBox(height: 5),
          Row(children: [
            //SizedBox(width: 25),
            CustomHeadingTitle(titleText: "Copertina"),
          ]),
          grid,
          Row(children: [
            //SizedBox(width: 25),
            CustomHeadingTitle(titleText: "Task"),
                      ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: BlurredBox(
                borderRadius: BorderRadius.circular(10),
                sigma: 15,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: taskInputController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () async {
                            
                            if(taskInputController.text.isNotEmpty) {
                              cTasks.add(Task(name: taskInputController.text,project: await DatabaseHelper.instance.getProjectByName( projectNameController.text)));
                            }
                            
                            taskInputController.clear();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: const Color.fromARGB(100, 0, 0, 0),
                      border: const OutlineInputBorder(
                          //borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Inserisci una task',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 192, 192, 192))),
                )),

            //TextButton(onPressed: () { }, child: Icon(Icons.add))
          ),
          taskCheckboxList,
          ElevatedButton(
            
              onPressed: () async { projectNameController.text.isEmpty || ProjectList.teamsList.isEmpty ? null : 
                
                {   projectItem = Project(
                    name: projectNameController.text,
                    description: projectDescriptionController.text,
                    status: "Attivo",
                    team: ProjectList.teamsList[selectedTeam],
                    thumbnail: ProjectList.thumbnailsList[grid.selectedThumbnail]
                    ),
                ProjectList.projectsList.add(projectItem),
                
                cTasks = await DatabaseHelper.instance.getTasksByProjectName(projectItem.name) ,
                    
                    projectNameController.clear(),
                    projectDescriptionController.clear(),
                    grid.selectedThumbnail = 0,
                    cTasks.clear(),
                    
                    showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Successo!'),
                                    content: Text(
                                        ("Il progetto \"${projectItem.name}\" è stato creato correttamente.\nPuoi creare altri progetti se ti va.")),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Ok'),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ),
                                ),
                    
                    };
              },
              child: const Row(mainAxisSize: MainAxisSize.min, children: [ Icon(Icons.add_task), SizedBox(width: 5,),Text("Aggiungi progetto") ]))
        ]));
  }
}



class SelectableTeamsList extends StatefulWidget {
  const SelectableTeamsList({super.key});

  @override
  State<SelectableTeamsList> createState() => _SelectableTeamsListState();
}

class _SelectableTeamsListState extends State<SelectableTeamsList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProjectList.teamsList.isNotEmpty ?
    Wrap(
              
              spacing: 5.0,
              children: List<Widget>.generate(
                ProjectList.teamsList.length,
                (int index) {
                  return ChoiceChip(
                    
                    selectedColor: Colors.pink,
                    iconTheme: const IconThemeData(color: Colors.white),
                    label: Text(ProjectList.teamsList[index].getName()),
                    selected: selectedTeam == index,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedTeam = selected ? index : 0;
                      });
                    },
                  );
                },
              ).toList(),
            )
    : const Expanded(child: Text("Non ci sono team disponibili. Non è possibile creare un progetto senza team."));
  }
  
}

