import 'dart:ui';
import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    projectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ClipRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: TextField(
                  controller: projectNameController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    filled: true,
                    fillColor: Color.fromARGB(68, 0, 0, 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none),
                    hintText: 'Inserisci il nome del progetto',
                  ),
                ))),
      ),
      const SizedBox(height: 5),
      const Row(children: [ SizedBox(width: 25), Text("Descrizione", style: TextStyle(color: Colors.black, fontFamily: 'SamsungSharpSans', fontWeight: FontWeight.bold, fontSize: 22),) ]),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ClipRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: TextField(
                  maxLines: 5,
                  controller: projectDescriptionController,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    filled: true,
                    fillColor: Color.fromARGB(68, 0, 0, 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none),
                    hintText: 'Questo progetto si pone l\' obiettivo di...',
                  ),
                ))),
      ),
      ElevatedButton(onPressed: () => { 
        projectDescriptionController.clear(),
        projectItem = new ProjectItem(projectNameController.text, projectDescriptionController.text, "Active", new Team("Team 1", List<Member>.from(<Member>[new Member("Mario", "Rossi", "Direttore"), new Member("Luigi", "Bianchi", "Operaio")]))),
        ProjectList().testList.add(projectItem),
        for(ProjectItem item in ProjectList().testList) {
            projectDescriptionController.text += item.toString()
        }
      }, child: Text("Aggiungi alla lista"))
    ]);
  }
}
