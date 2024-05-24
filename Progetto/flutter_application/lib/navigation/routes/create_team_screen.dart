import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/project_list.dart';

import '../../commonElements/blurred_box.dart';
import '../../commonElements/headings_title.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../commonElements/project_items.dart';

List<Member> selectedMembers = [];
final _items = ProjectList.membersList
      .map((member) =>
          MultiSelectItem<Member>(member, ("${member.name} ${member.surname}")))
      .toList();

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  

  
  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreen();
}

class _CreateTeamScreen extends State<CreateTeamScreen> {
  

  final teamNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: MediaQuery.of(context).orientation == Orientation.portrait
              ? 20
              : 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(children: [
            CustomHeadingTitle(titleText: "Nome team"),
          ]),
          SizedBox(
            height: 10,
          ),
          BlurredBox(
              borderRadius: 30,
              sigma: 15,
              child: TextField(
                maxLength: 50,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: const TextStyle(color: Colors.white),
                controller: teamNameController,
                decoration: const InputDecoration(
                    counterText: '',
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
          SizedBox(
            height: 10,
          ),
          Row(children: [
            CustomHeadingTitle(titleText: "Membri del team"),
          ]),
          SizedBox(
            height: 10,
          ),
          
          SelectableMembersList(),
          
          ElevatedButton(
              onPressed: () {
                teamNameController.text.isEmpty ? null : {

                  ProjectList.teamsList.add(Team(teamNameController.text, selectedMembers))
                };
              },
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.group_add),
                SizedBox(
                  width: 5,
                ),
                Text("Aggiungi team")
              ]))
        ],
      ),
    );
  }
}

class SelectableMembersList extends StatefulWidget {
  const SelectableMembersList({super.key});

  @override
  State<SelectableMembersList> createState() => _SelectableMembersListState();
}

class _SelectableMembersListState extends State<SelectableMembersList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlurredBox(
            borderRadius: 10,
            sigma: 15,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(100, 0, 0, 0),
              ),
              child: MultiSelectDialogField(
                
                listType: MultiSelectListType.CHIP,
                items: _items,
                title: const Text("Aggiungi membri"),
                selectedColor: Colors.pink,
                backgroundColor: Colors.white,
                
                
                cancelText: Text("Annulla", style: TextStyle(color: Colors.pink),),
                confirmText: Text("Conferma", style: TextStyle(color: Colors.pink),),
                checkColor: Colors.white,
                selectedItemsTextStyle: const TextStyle(color: Colors.black),
                decoration: const BoxDecoration(
                  
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  
                ),
                buttonIcon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                buttonText: const Text(
                  "Partecipanti al progetto",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  selectedMembers = results;
                },
              ),
            ),
          );
  }
  
}
 

Widget buildMembersGrid() {
  return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: ProjectList.membersList.length,
      itemBuilder: (context, index) {
        return Container();
      });
}
