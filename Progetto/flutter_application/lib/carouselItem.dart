import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import './projectItems.dart';
import 'package:css_colors/css_colors.dart';

Widget smallInfoContainer(Color containerColor, Color textColor, String text) {
  return Container(
    margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15))));
}

Widget statusCheck(ProjectItem testItem) {
  switch (testItem.status) {
              case 'Attivo':
                return smallInfoContainer(Colors.green, Colors.white, "Attivo");
              case 'Sospeso':
                return smallInfoContainer(Colors.amber, Colors.white, "Sospeso");
              case 'Archiviato':
                return smallInfoContainer(Colors.red, Colors.white, "Archiviato");
              default:
                return smallInfoContainer(Colors.grey, Colors.white, "Sconosciuto");
            }
          }


Widget teamCheck(ProjectItem testItem) {
  return Text(testItem.mainTeam.teamName,
      style: const TextStyle(color: Colors.black, fontSize: 13));
}

Widget getProjectName(ProjectItem testItem) {
  return Text(testItem.name,
      style: TextStyle(
          fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white));
}

Widget buildCarousel(int index, ProjectItem testItem) => Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: testItem.preview, fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //SizedBox(height: 0),
          //Align(alignment: Alignment(-0.5, 0), child: Text("Progetti recenti", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white))),
          Row(
            children: [
              SizedBox(width: 15),
              statusCheck(testItem),
            ],
          ),
          //SizedBox(height: 3),
          Column(
            children: [ Row(
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
          

          Container(
            height: 45,
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
                  ],
                  stops: [0.1, 0.5, 0.9],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                  height: 45,
                ),
                getProjectName(testItem),
              ],
            ),
          )]), //SizedBox(height: 10)
        ],
      ),
      //child: Image.network(urlImage, height: 300)
    );
