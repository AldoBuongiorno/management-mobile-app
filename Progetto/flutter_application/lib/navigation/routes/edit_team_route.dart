/*import 'dart:ui';
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

class EditTeamScreen extends StatefulWidget {
  const EditTeamScreen({super.key, required this.team});
  
  final Team team;

  @override
  State<EditTeamScreen> createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  
  late TextEditingController projectNameController;
  late TextEditingController projectDescriptionController;
  TextEditingController taskInputController = TextEditingController();

  

  @override
  void initState() {
    super.initState();
    teamNameController = TextEditingController(text: widget.project.name);
    teamDescriptionController = TextEditingController(text: widget.project.description);
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



/*
class MemberListView extends StatelessWidget {
  MemberListView(this.memberList, {super.key});
  List<Member> memberList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: memberList.length,
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  children: [
                    /*Icon(Icons.person, size: 35,),
                            SizedBox(width: 10,),*/
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Nome:'),
                        Text('Cognome:'),
                        Text('Ruolo:')
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              memberList[index].name),
                          Text(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              memberList[index].surname),
                          Text(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              memberList[index].role)
                        ])
                  ],
                )
              ],
            ),
          );
        }));
  }
}
*/



                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<List<Member>>(
                          future: _loadMembersByTeam(snapshot.data![index].getName()),
                          builder: (context, snapshotMembers) {
                            if (snapshotMembers.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshotMembers.hasError) {
                              return Text('Errore: ${snapshotMembers.error}');
                            } else {
                              return ExpandableTeamTile(snapshot.data![index].getName(),snapshotMembers.data!, index);
                            }
                          },
                        );
                      })


*/