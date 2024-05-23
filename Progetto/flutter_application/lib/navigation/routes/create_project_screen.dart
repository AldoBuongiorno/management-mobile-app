import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/blurred_box.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import '../../data/project_list.dart';
import '../../commonElements/project_items.dart';
import '../../commonElements/headings_title.dart';

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
    DropdownButtonExample mainTeamDropDown = const DropdownButtonExample();
    DropdownButtonExample secondaryTeamDropDown = const DropdownButtonExample();
    SelectableThumbnailGrid grid = SelectableThumbnailGrid();
    ProjectItem projectItem;
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 20
                    : 100),
        child: Column(children: [
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
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [mainTeamDropDown, secondaryTeamDropDown])),
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
                              ProjectList.tasksList.add(Task(taskInputController.text));
                            }
                            for(var item in ProjectList.tasksList) {
                              print(item.taskName);
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
            
              onPressed: () { projectNameController.text.isEmpty ? null : 
                
                { projectItem = ProjectItem(
                    projectNameController.text,
                    projectDescriptionController.text,
                    "Attivo",
                    Team(
                        "Team 1",
                        List<Member>.from(<Member>[
                          Member("Mario", "Rossi", "Direttore"),
                          Member("Luigi", "Bianchi", "Operaio")
                        ]))),
                ProjectList().getList().add(projectItem),
                

                projectItem.thumbnail = ProjectList().getThumbnailList()[grid
                    .getThumbnail()] };
              },
              child: const Text("Aggiungi alla lista"))
        ]));
  }
}

//da eliminare
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = ProjectList().getTeam().first.teamName;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).orientation == Orientation.portrait
            ? 160
            : 350,
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: DropdownButton<String>(
          //alignment: Alignment.topRight,
          //hint: Text('Team primario'),
          //dropdownColor: Colors.pink,
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          elevation: 8,
          style: const TextStyle(color: Colors.white),
          underline: const SizedBox(),
          //decoration: InputDecoration( ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: ProjectList()
              .getTeam()
              .map<DropdownMenuItem<String>>((Team value) {
            return DropdownMenuItem<String>(
              value: value.teamName,
              child: Text(
                value.teamName,
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
        ));
  }
}

class SelectableThumbnailGrid extends StatefulWidget {
  int choosenThumbnail = 0;

  int getThumbnail() {
    return choosenThumbnail;
  }

  @override
  _SelectableThumbnailGridState createState() =>
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
                                      ProjectList().getThumbnailList()[index],
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

class CheckboxListTileApp extends StatelessWidget {
  const CheckboxListTileApp({super.key});

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
        itemCount: ProjectList.tasksList.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            activeColor: Colors.pink,
            //side: BorderSide(color: Colors.lightBlue, width: 2),
            checkboxShape: CircleBorder(),
            title: Text(ProjectList.tasksList[index].taskName),
            value: ProjectList.tasksList[index].finished,
            onChanged: (bool? value) {
              setState(() {
                ProjectList.tasksList[index].finished =
                    value! ? true : false;
              });
            },
            secondary: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ProjectList.tasksList.removeAt(ProjectList.tasksList
                      .indexOf(ProjectList.tasksList[index]));
                  setState(() {});
                }), //Text((ProjectList().getTaskList().indexOf(task) + 1).toString(), style: TextStyle(fontSize: 16),),
          );
        });

  }
}
