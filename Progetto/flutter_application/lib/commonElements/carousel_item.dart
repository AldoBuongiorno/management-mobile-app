import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application/classes/all.dart';
import 'package:flutter_application/commonElements/tasks_checkbox_view.dart';
import '../data/database_helper.dart';
import '../navigation/routes/edit_project_route.dart';
import 'blurred_box.dart';

Widget smallInfoContainer(Color containerColor, Color textColor, String text,
    LinearGradient? gradient) {
  return Container(
      margin: const EdgeInsets.only(top: 10, left: 15),
      decoration: BoxDecoration(
          gradient: gradient,
          color: containerColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15))));
}

Widget statusCheck(Project testItem) {
  switch (testItem.getStatus()) {
    case 'Attivo':
      return smallInfoContainer(Colors.green, Colors.white, "Attivo", null);
    case 'Sospeso':
      return smallInfoContainer(Colors.amber, Colors.white, "Sospeso", null);
    case 'Archiviato':
      return smallInfoContainer(Colors.red, Colors.white, "Archiviato", null);
    case 'Fallito':
      return smallInfoContainer(Colors.red, Colors.white, "Fallito", null);
    case 'Completato':
      LinearGradient gradient = const LinearGradient(
        colors: [
          Color.fromARGB(255, 232, 232, 232),
          Color.fromARGB(255, 0, 183, 255),
          Color.fromARGB(255, 0, 183, 255),
          Color.fromARGB(255, 255, 0, 115),
          Color.fromARGB(255, 255, 0, 115),
          Colors.yellow
        ],
        stops: [0.7, 0.7, 0.80, 0.80, 0.90, 0.90],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      return smallInfoContainer(
          Colors.red, Colors.black, "Completato", gradient);
    default:
      return smallInfoContainer(Colors.grey, Colors.white, "Sconosciuto", null);
  }
}

Widget teamCheck(Project testItem) {
  return Text(testItem.getTeam()!.getName(),
      style: const TextStyle(color: Colors.black, fontSize: 13));
}

Widget getProjectName(Project testItem) {
  return Flexible(
      child: Container(
          child: Text(testItem.name,
              overflow: TextOverflow
                  .ellipsis, //e il testo è più lungo dello spazio disponibile nel widget, verrà visualizzato un segno di ellissi ("...") alla fine
              style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))));
}

Widget buildCarousel(int index, Project testItem, context) => Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: testItem.thumbnail, fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //SizedBox(height: 0),
          //Align(alignment: Alignment(-0.5, 0), child: Text("Progetti recenti", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              statusCheck(testItem),
              IconButton(
                  onPressed: () async {
                    List<Task> tasksList = await DatabaseHelper.instance
                        .getTasksByProjectName(testItem.name);
                    //double progress = await testItem.getProgress();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Task'),
                            content: SizedBox(
                                width: double.maxFinite,
                                child: TasksCheckboxViewForHomepage(
                                    tasks: tasksList)),
                            actions: [
                              TextButton(
                                child: Text('Conferma'),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.task_alt,
                    color: Colors.white,
                  ))
            ],
          ),
          //SizedBox(height: 3),
          Column(children: [
            Row(
              children: [
                const SizedBox(width: 12),
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: teamCheck(testItem)))
              ],
            ),
            BlurredBox(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
                sigma: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  decoration:
                      const BoxDecoration(color: Color.fromARGB(100, 0, 0, 0)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      getProjectName(testItem),
                    ],
                  ),
                ))
          ]), //SizedBox(height: 10)
        ],
      ),
      //child: Image.network(urlImage, height: 300)
    );
