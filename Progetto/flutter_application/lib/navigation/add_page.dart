import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/database_helper.dart';
import '../classes/setting_class.dart';
import '../commonElements/blurred_box.dart';
import 'routes/create_member_route.dart';
import 'routes/create_project_route.dart';
import 'package:input_quantity/input_quantity.dart';
import 'routes/create_team_route.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

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
            //physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()), // per evitare il bug della sfocatura
            child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 20
                        : 100),
                child: Column(children: [
                  FutureBuilder(
                      future: DatabaseHelper.instance.getSettings(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Setting>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center();
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
                                  //SizedBox(width: 10,),
                                  InputQty.int(
                                      //isIntrinsicWidth: false,
                                      decoration: QtyDecorationProps(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Colors.white)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                          isBordered: true,
                                          plusBtn: const Icon(
                                            Icons.add,
                                            color: Colors.pink,
                                          ),
                                          minusBtn: const Icon(
                                            Icons.remove,
                                            color: Colors.lightBlue,
                                          )),
                                      initVal:
                                          snapshot.data![0].number,
                                      minVal: 1,
                                      maxVal: 15,
                                      onQtyChanged: (value) =>
                                          DatabaseHelper.instance.updateSetting(
                                              'NumberOfProjectsOnHomepage',
                                              value))
                                ]),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                      child: Text(
                                          "Numero di team visualizzati in homepage:")),
                                  //SizedBox(width: 10,),
                                  InputQty.int(
                                      //isIntrinsicWidth: false,
                                      decoration: QtyDecorationProps(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Colors.white)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
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
                                          DatabaseHelper.instance.updateSetting(
                                              'NumberOfTeamsOnHomepage', value))
                                ])
                          ]);
                        }
                      }),
                      Row(children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 50,
                      child: BlurredBox(
                          borderRadius: BorderRadius.circular(10),
                          sigma: 15,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(50, 0, 0, 0)),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.library_add_check),
                                  Text(
                                    'Aggiungi progetto',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ]),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SecondRoute()));
                            },
                          ))),
                  const SizedBox(height: 5),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 50,
                      child: BlurredBox(
                          borderRadius: BorderRadius.circular(10),
                          sigma: 15,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(50, 0, 0, 0)),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_add),
                                  Text(
                                    'Aggiungi membro',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ]),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ToAddMemberRoute()));
                            },
                          ))),
                  const SizedBox(height: 5),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: BlurredBox(
                          borderRadius: BorderRadius.circular(10),
                          sigma: 15,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(50, 0, 0, 0)),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.group_add),
                                  Text(
                                    'Aggiungi team',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ]),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ToAddTeamRoute()));
                            },
                          ))),
                ])]))));
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

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

          //stops: [0.6, 0.7, 0.8, 0.9]
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
                  //titleTextStyle: TextStyle(color: Colors.white),
                  backgroundColor: const Color.fromARGB(100, 0, 0, 0),
                  title: const Text('Aggiungi progetto'),
                ),
              )),
            ),

            /*AppBar(
                backgroundColor: const Color.fromARGB(0, 255, 193, 7),
                title: const Text('Second Route'),
              ),*/
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics().applyTo(
                  const BouncingScrollPhysics()), // per evitare il bug della sfocatura
              child: Column(children: [
                const CreateProjectScreen(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Go back!'),
                ),
              ]),
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

          //stops: [0.6, 0.7, 0.8, 0.9]
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
                  //titleTextStyle: TextStyle(color: Colors.white),
                  backgroundColor: const Color.fromARGB(100, 0, 0, 0),
                  title: const Text('Aggiungi membro'),
                ),
              )),
            ),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics()
                  .applyTo(const BouncingScrollPhysics()),
              child: const Column(children: [
                CreateMemberScreen(),
              ]),
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

          //stops: [0.6, 0.7, 0.8, 0.9]
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
                  //titleTextStyle: TextStyle(color: Colors.white),
                  backgroundColor: const Color.fromARGB(100, 0, 0, 0),
                  title: const Text('Aggiungi team'),
                ),
              )),
            ),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics()
                  .applyTo(const BouncingScrollPhysics()),
              child: const Column(children: [
                CreateTeamScreen(),
              ]),
            )));
  }
}
