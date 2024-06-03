import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/commonElements/selectable_thumbnail_grid.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'package:flutter_application/data/thumbnail_list.dart';
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
    SelectableThumbnailGrid grid =
        SelectableThumbnailGrid(list: ProjectList.thumbnailsListTeam);
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
          const SizedBox(height: 10),
          Row(children: [
            //SizedBox(width: 25),
            CustomHeadingTitle(titleText: "Copertina"),
          ]),
          grid,
          ElevatedButton(
              onPressed: teamNameController.text.isEmpty
                  ? null
                  : () async {
                      await DatabaseHelper.instance
                              .teamExists(teamNameController.text)
                          ? showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Errore'),
                                content: Text(
                                    ("Il team \"${teamNameController.text}\" esiste già.")),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Ok'),
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ),
                            )
                          : {
                              selectedMembers.length < 2
                                  ? showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Errore'),
                                        content: const Text(
                                            ("Il team deve essere composto da almeno due membri.")),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'Ok'),
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    )
                                  : {
                                      checkIfMembersAreFree()
                                          ? {
                                              DatabaseHelper.instance.insertTeam(Team(
                                                  name: teamNameController.text,
                                                  thumbnail: ProjectList
                                                          .thumbnailsListTeam[
                                                      grid.selectedThumbnail])),
                                              for (Member member
                                                  in selectedMembers)
                                                {
                                                  DatabaseHelper.instance
                                                      .assignTeamToMember(
                                                          teamNameController
                                                              .text,
                                                          member.code!)
                                                },
                                              showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title:
                                                      const Text('Successo!'),
                                                  content: const Text(
                                                      ("Il team è stato creato.")),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context, 'Ok'),
                                                      child: const Text('Ok'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              teamNameController
                                                  .clear(), //selectedMembers.clear(), setState(() {})
                                            }
                                          : {
                                              showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: const Text('Errore'),
                                                  content: const Text(
                                                      ("Almeno uno dei membri del team è occupato.")),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context, 'Ok'),
                                                      child: const Text('Ok'),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            }
                                    }
                            };
                    },
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.group_add),
                SizedBox(
                  width: 5,
                ),
                Text("Aggiungi team")
              ])),
        ],
      ),
    );
  }

  bool checkIfMembersAreFree() {
    bool valid = true;
    for (Member member in selectedMembers) {
      valid = valid && member.isFree();
    }
    return valid;
  }
}

class SelectableMembersList extends StatefulWidget {
  const SelectableMembersList({Key? key}) : super(key: key);

  @override
  State<SelectableMembersList> createState() => _SelectableMembersListState();
}

class _SelectableMembersListState extends State<SelectableMembersList> {
  List<Member> selectedMembers = [];
  List<Member> allMembers = [];

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  Future<void> _loadMembers() async {
    List<Member> loadedMembers = await DatabaseHelper.instance.getMembers();
    setState(() {
      allMembers = loadedMembers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlurredBox(
          borderRadius: BorderRadius.circular(10),
          sigma: 15,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(100, 0, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white, // Imposta lo sfondo bianco
                    title: const Text("Aggiungi membri"),
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SizedBox(
                          width: double.maxFinite,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: allMembers.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                title: Text(
                                    "${allMembers[index].name} ${allMembers[index].surname}"),
                                value:
                                    selectedMembers.contains(allMembers[index]),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedMembers.add(allMembers[index]);
                                    } else {
                                      selectedMembers.remove(allMembers[index]);
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Annulla'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Conferma'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Partecipanti al progetto",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: selectedMembers.length,
          itemBuilder: (context, index) {
            Member member = selectedMembers[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Matricola:'),
                              Text('Nome:'),
                              Text('Cognome:'),
                              Text('Ruolo:'),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                member.getCode().toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                member.getMemberName(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                member.getMemberSurname(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                member.getMemberRole(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            selectedMembers.remove(member);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
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
