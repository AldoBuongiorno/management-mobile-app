import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'package:flutter_application/data/project_list.dart';
import '../../commonElements/blurred_box.dart';
import '../../commonElements/headings_title.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_application/classes/all.dart';

List<Member> selectedMembers = [];

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
          const SizedBox(
            height: 10,
          ),
          BlurredBox(
              borderRadius: BorderRadius.circular(30),
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
                    hintText: 'Inserisci il nome del team',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
              )),
          const SizedBox(
            height: 10,
          ),
          Row(children: [
            CustomHeadingTitle(titleText: "Membri del team"),
          ]),
          const SizedBox(
            height: 10,
          ),
          const SelectableMembersList(),
          ElevatedButton(
              onPressed: teamNameController.text.isEmpty ? null : () async {  
                await DatabaseHelper.instance.teamExists(teamNameController.text) ? 
                showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Errore'),
                            content: Text(
                                ("Il team \"${teamNameController.text}\" esiste già.")),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Ok'),
                                child: const Text('Ok'),
                              ),
                            ],
                          ),
                        )
              : {
                selectedMembers.length < 2 ? showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Errore'),
                            content: const Text(
                                ("Il team deve essere composto da almeno due membri.")),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Ok'),
                                child: const Text('Ok'),
                              ),
                            ],
                          ),
                        ) : {
                          checkIfMembersAreFree() ? {
                            DatabaseHelper.instance.insertTeam(Team(name: teamNameController.text)),
                            for(Member member in selectedMembers) {
                              DatabaseHelper.instance.assignTeamToMember(teamNameController.text, member.code)
                            },
                            showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Successo!'),
                            content: Text(
                                ("Il team ${teamNameController.text}")),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Ok'),
                                child: const Text('Ok'),
                              ),
                            ],
                          ),
                          
                        ), teamNameController.clear(), selectedMembers.clear()

                          } : {
                            showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Errore'),
                            content: const Text(
                                ("Almeno uno dei membri del team è occupato.")),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Ok'),
                                child: const Text('Ok'),
                              ),
                            ],
                          ),
                        )

                          }
                          
                          
                        }
              
              



              };
                /*Team team;
                teamNameController.text.isEmpty
                    ? null
                    : {
                        team = Team(name: teamNameController.text),
                        //ProjectList.teamsList.add(team),
                        DatabaseHelper.instance.insertTeam(team),

                        for(Member member in selectedMembers) {
                          if(member.mainTeam == null) { DatabaseHelper.instance.assignMainTeamToMember(team.name, member.code), member.mainTeam = team }
                          else if(member.secondaryTeam == null) { DatabaseHelper.instance.assignSecondaryTeamToMember(team.name, member.code), member.secondaryTeam = team }
                        },

                        teamNameController.clear,
                        selectedMembers.clear,

                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Successo!'),
                            content: Text(
                                ("Il team \"${team.getName()}\" è stato creato correttamente.\nPuoi creare altri team se ti va.")),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Ok'),
                                child: const Text('Ok'),
                              ),
                            ],
                          ),
                        ),
                      };
              },*/ },
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

bool checkIfMembersAreFree() {
  bool valid = true;
  for(Member member in selectedMembers) {
    valid = valid && member.isFree();
  }
  return valid;
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

  Future<List<Member>> _loadMembers() async {
    return await DatabaseHelper.instance.getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadMembers(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return BlurredBox(
              borderRadius: BorderRadius.circular(10),
              sigma: 15,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
                child: MultiSelectDialogField(
                  listType: MultiSelectListType.CHIP,
                  items: snapshot.data!
                      .map((member) => MultiSelectItem<Member>(
                          member, ("${member.name} ${member.surname}")))
                      .toList(),
                  title: const Text("Aggiungi membri"),
                  selectedColor: Colors.pink,
                  backgroundColor: Colors.white,
                  cancelText: const Text(
                    "Annulla",
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                  confirmText: const Text(
                    "Conferma",
                    style: TextStyle(color: Colors.pink),
                  ),
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
        });
  }
}

/*Widget buildMembersGrid() {
  return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: ProjectList.membersList.length,
      itemBuilder: (context, index) {
        return Container();
      });
}*/
