import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/blurredBox.dart';
import './projectList/projectList.dart';
import 'projectItems.dart';

class ProjectNameForm extends StatefulWidget {
  const ProjectNameForm({super.key});

  @override
  State<ProjectNameForm> createState() => _ProjectNameFormState();
}

class _ProjectNameFormState extends State<ProjectNameForm> {
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
    DropdownButtonExample mainTeamDropDown = DropdownButtonExample();
    DropdownButtonExample secondaryTeamDropDown = DropdownButtonExample();
    SelectableThumbnailGrid grid = SelectableThumbnailGrid();
    ProjectItem projectItem;
    return Column(children: [
      const SizedBox(height: 20),
      const Row(children: [
        SizedBox(width: 25),
        Text(
          "Nome",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'SamsungSharpSans',
              fontWeight: FontWeight.bold,
              fontSize: 22),
        )
      ]),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: BlurredBox(
            borderRadius: 10,
            sigma: 5,
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
                  hintStyle: TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
            )),
      ),
      const SizedBox(height: 5),
      const Row(children: [
        SizedBox(width: 25),
        Text(
          "Descrizione",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'SamsungSharpSans',
              fontWeight: FontWeight.bold,
              fontSize: 22),
        )
      ]),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: BlurredBox(
            borderRadius: 10,
            sigma: 5,
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
                  hintStyle: TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
            )),
      ),
      const SizedBox(height: 5),
      const Row(children: [
        SizedBox(width: 25),
        Text(
          "Team",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'SamsungSharpSans',
              fontWeight: FontWeight.bold,
              fontSize: 22),
        )
      ]),
      const SizedBox(height: 5),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [mainTeamDropDown, secondaryTeamDropDown])),
      const SizedBox(height: 5),
      const Row(children: [
        SizedBox(width: 25),
        Text(
          "Copertina",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'SamsungSharpSans',
              fontWeight: FontWeight.bold,
              fontSize: 22),
        )
      ]),
      
      grid,

      const Row(children: [
      SizedBox(width: 25),
        Text(
          "Task",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'SamsungSharpSans',
              fontWeight: FontWeight.bold,
              fontSize: 22),
        )
      ]),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: BlurredBox(
            borderRadius: 10,
            sigma: 5,
            child: TextField(
              
              style: const TextStyle(color: Colors.white),
              controller: taskInputController,
              decoration: InputDecoration(
                suffixIcon: IconButton(onPressed: () { ProjectList().getTaskList().add(Task(taskInputController.text)); taskInputController.clear(); }, icon: Icon(Icons.add, color: Colors.white,)),
                
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  filled: true,
                  fillColor: Color.fromARGB(100, 0, 0, 0),
                  border: OutlineInputBorder(
                      //borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Inserisci una task',
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 192, 192, 192))),
            )),

            //TextButton(onPressed: () { }, child: Icon(Icons.add))
            
      ),
      taskCheckboxList,

      ElevatedButton(
          onPressed: () {
            //projectDescriptionController.clear();
            projectItem = ProjectItem(
                projectNameController.text,
                projectDescriptionController.text,
                "Attivo",
                Team(
                    "Team 1",
                    List<Member>.from(<Member>[
                      Member("Mario", "Rossi", "Direttore"),
                      Member("Luigi", "Bianchi", "Operaio")
                    ])));
            ProjectList().getList().add(projectItem);
            for (ProjectItem item in ProjectList().getList()) {
              print(item.toString());
            }

            projectItem.preview = ProjectList().getThumbnailList()[grid
                .getThumbnail()]; //AssetImage('assets/images/projectPreview/engineering.jpg');
          },
          child: const Text("Aggiungi alla lista"))
    ]);
  }
}

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
        padding: EdgeInsets.only(right: 10),
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
          underline: SizedBox(),
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
                style: TextStyle(color: Colors.black),
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                    decoration: BoxDecoration(
                                        color:
                                            const Color.fromARGB(100, 0, 0, 0)),
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
  const CheckboxListTileExample({super.key});

  @override
  State<CheckboxListTileExample> createState() =>
      _CheckboxListTileExampleState();
}

class _CheckboxListTileExampleState extends State<CheckboxListTileExample> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ProjectList().getTaskList().length,
      itemBuilder: (context, index) {
      return CheckboxListTile(
            activeColor: Colors.pink,
            
          title: Text(ProjectList().getTaskList()[index].taskName),
          value: ProjectList().getTaskList()[index].finished,
          onChanged: (bool? value) {
            setState(() {
              ProjectList().getTaskList()[index].finished = value! ? true : false;
              
            });
          },
          secondary: IconButton(icon: Icon(Icons.delete), onPressed: () { ProjectList().getTaskList().removeAt(ProjectList().getTaskList().indexOf(ProjectList().getTaskList()[index])); }), //Text((ProjectList().getTaskList().indexOf(task) + 1).toString(), style: TextStyle(fontSize: 16),),
        );
    });
        
        
    
    
    
    /*Column (
        children: [  for(Task task in ProjectList().getTaskList())
          CheckboxListTile(
            activeColor: Colors.pink,
            
          title: Text(task.taskName),
          value: task.finished,
          onChanged: (bool? value) {
            setState(() {
              task.finished = value! ? true : false;
              
            });
          },
          secondary: IconButton(icon: Icon(Icons.delete), onPressed: () { ProjectList().getTaskList().removeAt(ProjectList().getTaskList().indexOf(task)); }), //Text((ProjectList().getTaskList().indexOf(task) + 1).toString(), style: TextStyle(fontSize: 16),),
        ),
      ]);*/
    
  }
}
