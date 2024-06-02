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

  

  @override
  void initState() {
    super.initState();
    projectNameController = TextEditingController(text: widget.project.name);
    projectDescriptionController = TextEditingController(text: widget.project.description);
  }

  @override
  void dispose() {
    projectNameController.dispose();
    super.dispose();
  }

  Future<TasksCheckboxView> _loadTasks() async {
    List<Task> tasks = await DatabaseHelper.instance.getTasksByProjectName(widget.project.name);
    return TasksCheckboxView(tasks: tasks);
  }

  @override
  Widget build(BuildContext context) {
    SelectableThumbnailGrid grid = SelectableThumbnailGrid(ProjectList.thumbnailsList.indexOf(widget.project.thumbnail));


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

          //stops: [0.6, 0.7, 0.8, 0.9]
        )),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 55),
              child: BlurredBox( borderRadius: BorderRadius.zero ,sigma: 15 ,child: AppBar(
                  foregroundColor: Colors.white,
                  //titleTextStyle: TextStyle(color: Colors.white),
                  backgroundColor: const Color.fromARGB(100, 0, 0, 0),
                  title: Text('Modifica ${widget.project.name}')),
                ),
              ),
            body: SingleChildScrollView(
              child: Container(
        margin: getResponsivePadding(context),
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
                  //initialValue: ProjectList.projectsList[widget.index].name,
                  style: const TextStyle(color: Colors.white),
                  controller: projectNameController,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: const Color.fromARGB(100, 0, 0, 0),
                      border: const OutlineInputBorder(
                          //borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                          
                      hintText: widget.project.name,
                      hintStyle:
                          const TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
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


                    //SelectableTeamsList(),




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
                              List<Task> tasksList = await DatabaseHelper.instance.getTasksByProjectName(widget.project.name);
                              DatabaseHelper.instance.insertTask(Task(name: taskInputController.text, project: widget.project));
                              tasksList.add(Task(name: taskInputController.text, project: widget.project));
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
          FutureBuilder<TasksCheckboxView>(
                    future: _loadTasks(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Errore: ${snapshot.error}'));
                      } else {
                        return snapshot.data!;
                      }
                    },
                  ),
          ElevatedButton(
            
              onPressed: () {  
                
                {   /*ProjectList.projectsList[widget.index].name = projectNameController.text;
                    ProjectList.projectsList[widget.index].description = projectDescriptionController.text;
                    ProjectList.projectsList[widget.index].thumbnail = ProjectList.thumbnailsList[grid.selectedThumbnail];*/
                    //ProjectList.projectsList[widget.index].tasks = projectDescriptionController.text,
                    
                    DatabaseHelper.instance.updateProjectName(widget.project.name, projectNameController.text);
                    DatabaseHelper.instance.updateDescription(projectNameController.text, projectDescriptionController.text);
                    DatabaseHelper.instance.updateThumbnail(projectNameController.text, ProjectList.thumbnailsList[grid.selectedThumbnail].assetName);

                    
                    showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Successo!'),
                                    content: Text(
                                        ("Il progetto \"${widget.project.name}\" è stato modificato correttamente.")),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Ok'),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                                
                    
                    };
              },
              child: const Row(mainAxisSize: MainAxisSize.min, children: [ Icon(Icons.save), SizedBox(width: 5,),Text("Modifica progetto") ]))
        ])))));

  }


}