import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import 'package:flutter_application/data/database_helper.dart';
import '../classes/setting_class.dart';
import '../commonElements/blurred_box.dart';
import 'routes/create_member_route.dart';
import 'routes/create_project_route.dart';
import 'package:input_quantity/input_quantity.dart';
import 'routes/create_team_route.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return addProjectButton();
  }
}

Widget addProjectButton() {
  return const FirstRoute();
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 20
                        : 100),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomHeadingTitle(titleText: 'Impostazioni'),
                      const SizedBox(height: 10),
                      FutureBuilder(
                          future: DatabaseHelper.instance.getSettings(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Setting>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Column(children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                          child: Text(
                                              "Numero di progetti visualizzati in homepage:")),
                                      InputQty.int(
                                          decoration: QtyDecorationProps(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      width: 2,
                                                      color: Colors.white)),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              isBordered: true,
                                              plusBtn: const Icon(
                                                Icons.add,
                                                color: Colors.pink,
                                              ),
                                              minusBtn: const Icon(
                                                Icons.remove,
                                                color: Colors.lightBlue,
                                              )),
                                          initVal: snapshot.data![0].number,
                                          minVal: 1,
                                          maxVal: 15,
                                          onQtyChanged: (value) => DatabaseHelper
                                              .instance
                                              .updateSetting(
                                                  'NumberOfProjectsOnHomepage',
                                                  value))
                                    ]),
                                const SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                          child: Text(
                                              "Numero di team visualizzati in homepage:")),
                                      InputQty.int(
                                          decoration: QtyDecorationProps(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      width: 2,
                                                      color: Colors.white)),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              isBordered: true,
                                              plusBtn: const Icon(
                                                Icons.add,
                                                color: Colors.pink,
                                              ),
                                              minusBtn: const Icon(
                                                Icons.remove,
                                                color: Colors.lightBlue,
                                              )),
                                          initVal: snapshot.data![1].number,
                                          minVal: 1,
                                          maxVal: 10,
                                          onQtyChanged: (value) =>
                                              DatabaseHelper.instance
                                                  .updateSetting(
                                                      'NumberOfTeamsOnHomepage',
                                                      value))
                                    ])
                              ]);
                            }
                          }),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    minimumSize: const Size.fromHeight(80),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    foregroundColor: Colors.lightBlue,
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ToAddProjectRoute()));
                                  },
                                  child: const Icon(Icons.add_task, size: 40))),
                          const SizedBox(width: 5),
                          Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    minimumSize: const Size.fromHeight(80),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    foregroundColor: Colors.pink,
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ToAddMemberRoute()));
                                  },
                                  child:
                                      const Icon(Icons.person_add, size: 40))),
                          const SizedBox(width: 5),
                          Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    minimumSize: const Size.fromHeight(80),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    foregroundColor:
                                        const Color.fromARGB(255, 245, 220, 0),
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ToAddTeamRoute()));
                                  },
                                  child: const Icon(Icons.group_add, size: 40)))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                                child: Text("Elimina tutti i dati presenti:")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Elimina dati'),
                                      content: const Text(
                                          "Una volta che i dati sono stati eliminati,non sarà più possibile recuperarli.\nSei sicuro di voler procedere?"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Annulla'),
                                          child: const Text('Annulla',
                                              style: TextStyle(
                                                  color: Colors.lightBlue)),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await DatabaseHelper.instance
                                                .wipeDatabase();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              elevation: 0,
                                              padding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              content: Container(
                                                  color: const Color.fromARGB(
                                                      156, 0, 0, 0),
                                                  child: const BlurredBox(
                                                      sigma: 20,
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      child: Column(
                                                          children: [
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                                'Tutti i dati sono stati eliminati'),
                                                            SizedBox(height: 10)
                                                          ]))),
                                            ));
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Conferma',
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.delete_forever),
                                    SizedBox(width: 5),
                                    Text('Elimina dati')
                                  ],
                                )),
                          ]),
                      const SizedBox(height: 10),
                    ]))));
  }
}

class ToAddProjectRoute extends StatelessWidget {
  const ToAddProjectRoute({super.key});

  @override
  Widget build(BuildContext context) {
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
        )),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 55),
              child: ClipRect(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: AppBar(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(100, 0, 0, 0),
                  title: const Text('Aggiungi progetto'),
                ),
              )),
            ),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics().applyTo(
                  const BouncingScrollPhysics()), // per evitare il bug della sfocatura
              child: const Column(children: [CreateProjectScreen()]),
            )));
  }
}

class ToAddMemberRoute extends StatelessWidget {
  const ToAddMemberRoute({super.key});

  @override
  Widget build(BuildContext context) {
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
        )),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 55),
              child: ClipRect(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: AppBar(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(100, 0, 0, 0),
                  title: const Text('Aggiungi membro'),
                ),
              )),
            ),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics()
                  .applyTo(const BouncingScrollPhysics()),
              child: const Column(children: [CreateMemberScreen()]),
            )));
  }
}

class ToAddTeamRoute extends StatelessWidget {
  const ToAddTeamRoute({super.key});

  @override
  Widget build(BuildContext context) {
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
        )),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 55),
              child: ClipRect(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: AppBar(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(100, 0, 0, 0),
                  title: const Text('Aggiungi team'),
                ),
              )),
            ),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics()
                  .applyTo(const BouncingScrollPhysics()),
              child: const Column(children: [CreateTeamScreen()]),
            )));
  }
}
