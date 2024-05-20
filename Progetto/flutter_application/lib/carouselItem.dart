import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import './projectItems.dart';
import 'package:css_colors/css_colors.dart';

Widget statusCheck(ProjectItem testItem) {
  switch (testItem.status) {
    case 'Attivo':
      return const Text("Attivo",
          style: TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15));
    case 'Sospeso':
      return const Text("Sospeso",
          style: TextStyle(
              color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 15));
    case 'Archiviato':
      return const Text("Archiviato",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15));
    default:
      return const Text("Sconosciuto",
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15));
  }
}

Widget teamCheck(ProjectItem testItem) {
  return Text(testItem.mainTeam.teamName,  style: const TextStyle(color: Colors.black, fontSize: 13));
}

Widget getProjectName(ProjectItem testItem) {
  return Text(testItem.name, style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white));
}

Widget buildCarousel(int index, ProjectItem testItem) =>
    Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: testItem.preview, fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column( mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 5),
          //Align(alignment: Alignment(-0.5, 0), child: Text("Progetti recenti", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white))),
          Row(
            children: [
              SizedBox(width: 15),
              /*const Text(
                "stato ",
                style: TextStyle(fontSize: 13),
              ),*/
              statusCheck(testItem),
            ],
          ),
          SizedBox(height: 3),
          Container(
            child: Row(
              children: [
                SizedBox(width: 12),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: teamCheck(testItem)))
              ],
            ),
          ),

          Container(
            height: 50,
            alignment: Alignment.bottomLeft,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                //Color.fromARGB(151, 0, 0, 0),
                Color.fromARGB(173, 0, 0, 0),
                Color.fromARGB(203, 0, 0, 0)
                
              ], stops: [0.1, 0.5, 0.9],
            ), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)) ),
            child: Row(
              children: [
                SizedBox(
                  width: 15, height: 45,
                ),
                
              getProjectName(testItem),

              ],
            ),
          ), //SizedBox(height: 10)
        ],
      ),
      //child: Image.network(urlImage, height: 300)
    );
