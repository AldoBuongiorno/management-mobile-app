import 'dart:ui';

import 'package:flutter/material.dart';
import './createProject.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return addProjectButton();
  }
}

Widget addProjectButton() {
  return FirstRoute();
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      SizedBox(
        height: 400,
      ),
      ElevatedButton(
        //style: ButtonStyle(backgroundColor: MaterialColor(primary, swatch)),
        child: const Text(
          'Open route',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SecondRoute()));
        },
      ),
    ])));
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return /*Container(
      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/projectPreview/engineering.jpg'))),
        child: */
        Container(
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
              backgroundColor: Color.fromARGB(0, 0, 0, 0),
              appBar: PreferredSize(
                child: Container(
                  child: ClipRect(
                      child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: AppBar(
                      foregroundColor: Colors.white,
                      //titleTextStyle: TextStyle(color: Colors.white),
                      backgroundColor: const Color.fromARGB(100, 0, 0, 0),
                      title: const Text('Aggiungi progetto'),
                    ),
                  )),
                ),
                preferredSize: Size(MediaQuery.of(context).size.width, 55),
              ),

              /*AppBar(
                backgroundColor: const Color.fromARGB(0, 255, 193, 7),
                title: const Text('Second Route'),
              ),*/
              body: SingleChildScrollView(child:  Column(children: [
                ProjectNameForm(),
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
