import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/project_list.dart';
import '../../commonElements/blurred_box.dart';
import '../../commonElements/headings_title.dart';
import 'package:flutter_application/classes/all.dart';

class CreateMemberScreen extends StatefulWidget {
  const CreateMemberScreen({super.key});
  @override
  State<CreateMemberScreen> createState() => _CreateMemberScreen();
}

class _CreateMemberScreen extends State<CreateMemberScreen> {
  final memberNameController = TextEditingController();
  final memberSurnameController = TextEditingController();
  final memberRoleController = TextEditingController();
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
            CustomHeadingTitle(titleText: "Nome membro"),
          ]),
          SizedBox(
            height: 10,
          ),
          BlurredBox(
              borderRadius: BorderRadius.circular(30),
              sigma: 15,
              child: TextField(
                maxLength: 50,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: const TextStyle(color: Colors.white),
                controller: memberNameController,
                decoration: const InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    filled: true,
                    fillColor: Color.fromARGB(100, 0, 0, 0),
                    border: OutlineInputBorder(
                        //borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Inserisci il nome',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
              )),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            CustomHeadingTitle(titleText: "Cognome membro"),
          ]),
          SizedBox(
            height: 10,
          ),
          BlurredBox(
              borderRadius: BorderRadius.circular(30),
              sigma: 15,
              child: TextField(
                maxLength: 50,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: const TextStyle(color: Colors.white),
                controller: memberSurnameController,
                decoration: const InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    filled: true,
                    fillColor: Color.fromARGB(100, 0, 0, 0),
                    border: OutlineInputBorder(
                        //borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Inserisci il cognome',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
              )),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            CustomHeadingTitle(titleText: "Ruolo membro"),
          ]),
          SizedBox(
            height: 10,
          ),
          BlurredBox(
              borderRadius: BorderRadius.circular(30),
              sigma: 15,
              child: TextField(
                maxLength: 50,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: const TextStyle(color: Colors.white),
                controller: memberRoleController,
                decoration: const InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    filled: true,
                    fillColor: Color.fromARGB(100, 0, 0, 0),
                    border: OutlineInputBorder(
                        //borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Inserisci il ruolo',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
              )),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Member member;
                (memberNameController.text.isEmpty ||
                        memberSurnameController.text.isEmpty ||
                        memberRoleController.text.isEmpty)
                    ? null
                    : {
                        member = Member(
                            memberNameController.text,
                            memberSurnameController.text,
                            memberRoleController.text),
                          true
                            ? {
                                ProjectList.membersList.add(member),
                                memberNameController.clear(),
                                memberSurnameController.clear(),
                                memberRoleController.clear(),
                                //Navigator.pop(context),
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Successo!'),
                                    content: Text(
                                        ("${member.name} ${member.surname} è stato inserito correttamente.\nPuoi inserire altri membri se ti va.")),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Ok'),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ),
                                ),
                              }
                            : {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Errore.'),
                                    content: Text(
                                        "${member.name} ${member.surname} è già presente."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Riprova'),
                                        child: const Text('Riprova'),
                                      ),
                                    ],
                                  ),
                                )
                              }
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

class DialogAlert extends StatelessWidget {
  const DialogAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Successo'),
          content: const Text('Il membro è stato inserito correttamente.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
