// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/blurred_box.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import '../../data/project_list.dart';
import '../../commonElements/headings_title.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_application/classes/all.dart';

int selectedTeam = 0;
List<Task> tasks = [];


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
    CheckboxListTileExample taskCheckboxList = CheckboxListTileExample();
    SelectableThumbnailGrid grid = SelectableThumbnailGrid();
    ProjectItem projectItem;
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
                borderRadius: 30,
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
                borderRadius: 10,
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
                borderRadius: 10,
                sigma: 15,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: taskInputController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            
                            if(taskInputController.text.isNotEmpty) {
                              tasks.add(Task(taskInputController.text));
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
            
              onPressed: () { projectNameController.text.isEmpty || ProjectList.teamsList.isEmpty ? null : 
                
                {   projectItem = ProjectItem(
                    projectNameController.text,
                    projectDescriptionController.text,
                    "Attivo",
                    ProjectList.teamsList[selectedTeam]),
                ProjectList.projectsList.add(projectItem),
                
                projectItem.tasks = tasks,
                projectItem.thumbnail = ProjectList.thumbnailsList[grid.choosenThumbnail] ,
                    
                    projectNameController.clear(),
                    projectDescriptionController.clear(),
                    grid.choosenThumbnail = 0,
                    tasks.clear(),
                    
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



class SelectableThumbnailGrid extends StatefulWidget {
  int choosenThumbnail = 0;

  int getThumbnail() {
    return choosenThumbnail;
  }

  @override
  State<SelectableThumbnailGrid> createState() =>
      _SelectableThumbnailGridState();
}

class _SelectableThumbnailGridState extends State<SelectableThumbnailGrid> {
  int selectedThumbnail = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: ProjectList().getThumbnailList().length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 3,
              childAspectRatio:
                  2, //MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedThumbnail = index;
                      widget.choosenThumbnail = index;
                    });
                  },
                  child: Card(
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      ProjectList.thumbnailsList[index],
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)),
                          height: 200,
                          width: 200,
                          child: selectedThumbnail == index
                              ? BlurredBox(
                                  borderRadius: 10,
                                  sigma: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(100, 0, 0, 0)),
                                    child: Center(
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? 35
                                            : 45,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox())));
            }));
  }
}

class TasksCheckboxList extends StatelessWidget {
  const TasksCheckboxList({super.key});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTileExample();
  }
}

class CheckboxListTileExample extends StatefulWidget {
  CheckboxListTileExample({super.key});

  @override
  State<CheckboxListTileExample> createState() =>
      _CheckboxListTileExampleState();
}

class _CheckboxListTileExampleState extends State<CheckboxListTileExample> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            activeColor: Colors.pink,
            //side: BorderSide(color: Colors.lightBlue, width: 2),
            checkboxShape: const CircleBorder(),
            title: Text(tasks[index].taskName),
            value: tasks[index].finished,
            onChanged: (bool? value) {
              setState(() {
                tasks[index].finished =
                    value! ? true : false;
              });
            },
            secondary: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  tasks.removeAt(tasks
                      .indexOf(tasks[index]));
                  setState(() {});
                }), //Text((ProjectList().getTaskList().indexOf(task) + 1).toString(), style: TextStyle(fontSize: 16),),
          );
        });

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
                    label: Text(ProjectList.teamsList[index].teamName),
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
    : const Text("Non ci sono team disponibili. Non è possibile creare un progetto senza team.");
  }
  
}

