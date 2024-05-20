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

  @override
  void dispose() {
    projectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: BlurredBox(borderRadius: 10, sigma: 5,
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
                    hintStyle: TextStyle(color: Colors.white)
                  ),
        )),
      ),
      const SizedBox(height: 5),
      const Row(children: [ SizedBox(width: 25), Text("Descrizione", style: TextStyle(color: Colors.black, fontFamily: 'SamsungSharpSans', fontWeight: FontWeight.bold, fontSize: 22),) ]),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: BlurredBox(borderRadius: 10, sigma: 5,
                child: TextField(
                  
                  style: const TextStyle(color: Colors.white),
                  maxLines: 5,
                  controller: projectDescriptionController,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    filled: true,
                    fillColor: Color.fromARGB(100, 0, 0, 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none),
                    hintText: 'Questo progetto si pone l\' obiettivo di...',
                    hintStyle: TextStyle(color: Colors.white)
                  ),
                )),
      ),
      const SizedBox(height: 5),
      const Row(children: [ SizedBox(width: 25), Text("Team", style: TextStyle(color: Colors.black, fontFamily: 'SamsungSharpSans', fontWeight: FontWeight.bold, fontSize: 22),) ]),
      Padding( padding: EdgeInsets.symmetric(horizontal: 25), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: [  DropdownButtonExample(), DropdownButtonExample() ])),
      const SizedBox(height: 5),
      const Row(children: [ SizedBox(width: 25), Text("Copertina", style: TextStyle(color: Colors.black, fontFamily: 'SamsungSharpSans', fontWeight: FontWeight.bold, fontSize: 22),) ]),
      grid,

      ElevatedButton(onPressed: () { 
        //projectDescriptionController.clear();
        projectItem = ProjectItem(projectNameController.text, projectDescriptionController.text, "Active", new Team("Team 1", List<Member>.from(<Member>[new Member("Mario", "Rossi", "Direttore"), new Member("Luigi", "Bianchi", "Operaio")])));
        ProjectList().getList().add(projectItem);
        for(ProjectItem item in ProjectList().getList()) {
            print(item.toString());
        }
        
        projectItem.preview = ProjectList().getThumbnailList()[grid.getThumbnail()];//AssetImage('assets/images/projectPreview/engineering.jpg');
      }, child: const Text("Aggiungi alla lista"))
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
    return DropdownButton<String>(
      
      //dropdownColor: Colors.pink,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      
      //decoration: InputDecoration( ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: ProjectList().getTeam().map<DropdownMenuItem<String>>((Team value) {
        return DropdownMenuItem<String>(
          
          value: value.teamName,
          child: Text(value.teamName),
        );
      }).toList(),
    );
  }
}














class SelectableThumbnailGrid extends StatefulWidget {
  
  int choosenThumbnail = 0;

  int getThumbnail() {
    return choosenThumbnail;
  }
  @override
  _SelectableThumbnailGridState createState() => _SelectableThumbnailGridState();

}

class _SelectableThumbnailGridState extends State<SelectableThumbnailGrid> {

  int selectedThumbnail = 0;

 

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: ProjectList().getThumbnailList().length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
          childAspectRatio: 2, //MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),
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
                decoration: BoxDecoration(image: DecorationImage(image: ProjectList().getThumbnailList()[index], fit: BoxFit.cover), borderRadius: BorderRadius.circular(10)),
                height: 200,
                width: 200,
                child: selectedThumbnail == index ? BlurredBox(borderRadius: 10, sigma: 2,
                  child: Container(
                  decoration: BoxDecoration(color: const Color.fromARGB(100, 0, 0, 0)),
                  child: Center(child: Icon(Icons.check_circle, color: Colors.white, size: MediaQuery.of(context).orientation == Orientation.portrait ? 35 : 45,),
                ),
              ),
            ) : const SizedBox())));
        }));
  }
}