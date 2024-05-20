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
                        borderRadius: BorderRadius.circular(10),
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
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Questo progetto si pone l\' obiettivo di...',
                  ),
                ))),
      ),
      const SizedBox(height: 5),
      const Row(children: [ SizedBox(width: 25), Text("Copertina", style: TextStyle(color: Colors.black, fontFamily: 'SamsungSharpSans', fontWeight: FontWeight.bold, fontSize: 22),) ]),
      //MyGridView(),
      ElevatedButton(onPressed: () { 
        //projectDescriptionController.clear();
        projectItem = new ProjectItem(projectNameController.text, projectDescriptionController.text, "Active", new Team("Team 1", List<Member>.from(<Member>[new Member("Mario", "Rossi", "Direttore"), new Member("Luigi", "Bianchi", "Operaio")])));
        ProjectList().getList().add(projectItem);
        for(ProjectItem item in ProjectList().getList()) {
            print(item.toString());
        }
        projectItem.preview = AssetImage('assets/images/projectPreview/engineering.jpg');
      }, child: Text("Aggiungi alla lista"))
    ]);
  }
}



class MyGridView extends StatefulWidget {
  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {

  // Set an int with value -1 since no card has been selected
  int selectedCard = -1;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        itemCount: 10,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3),
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                // Ontap of each card, set the defined int to the grid view index
                selectedCard = index;
              });
            },
            child: Card(
              // Check if the index is equal to the selected Card integer
              color: selectedCard == index ? Colors.blue : Colors.amber,
              child: Container(
                height: 200,
                width: 200,
                child: Center(
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}