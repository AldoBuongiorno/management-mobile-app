import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import 'package:flutter_application/commonElements/responsive_padding.dart';
import 'package:flutter_application/commonElements/tasks_checkbox_view.dart';
import '../../commonElements/blurred_box.dart';
import 'package:flutter_application/classes/all.dart';
import '../../commonElements/carousel_item.dart';
import '../../data/database_helper.dart';
import 'edit_project_route.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ProjectRoute extends StatefulWidget {
  Project project;
  ProjectRoute(this.project, {super.key});

  @override
  State<ProjectRoute> createState() => _ProjectRouteState();
}

class _ProjectRouteState extends State<ProjectRoute> {
  Future<List<Task>> _loadTasks() async {
    return await DatabaseHelper.instance
        .getTasksByProjectName(widget.project.name);
  }

  @override
  Widget build(BuildContext context) {
    final failureReasonController = TextEditingController();
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
              child: BlurredBox(
                borderRadius: BorderRadius.zero,
                sigma: 5,
                child: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProjectScreen(
                                      project: widget.project,
                                    ))).then((_) => setState(() {})),
                        icon: const Icon(Icons.draw))
                  ],
                  foregroundColor: Colors.white,
                  //titleTextStyle: TextStyle(color: Colors.white),
                  backgroundColor: const Color.fromARGB(100, 0, 0, 0),
                  title: Text(widget.project.name),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: getResponsivePadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomHeadingTitle(titleText: "Descrizione"),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(children: [
                            Expanded(child: Text(widget.project.description))
                          ]),
                        )),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Poppins'),
                          text:
                              'Attualmente al progetto sta lavorando il team '),
                      TextSpan(
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                          text: "${widget.project.team!.name}."),
                    ])),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.punch_clock),
                            const SizedBox(width: 10),
                            Flexible(
                                child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Data creazione:\t${DateFormat('dd-MM-yyyy').format(widget.project.creationDate!)}'))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 10),
                            Flexible(
                                child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Ultima modifica:\t ${DateFormat('dd-MM-yyyy hh:mm:ss').format(widget.project.lastModified!)}'))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(width: 10),
                            Flexible(
                                child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Data scadenza:\t${DateFormat('dd-MM-yyyy').format(widget.project.expirationDate!)}'))
                          ],
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.pink),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DatePickerDialog(
                                        currentDate:
                                            widget.project.expirationDate,
                                        cancelText: 'Annulla',
                                        confirmText: 'Conferma',
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 500)));
                                  }).then((selectedDate) {
                                selectedDate != null
                                    ? {
                                        DatabaseHelper.instance
                                            .updateExpirationDate(
                                                widget.project.name,
                                                selectedDate),
                                        setState(() {
                                          widget.project.expirationDate =
                                              selectedDate;
                                          widget.project.lastModified =
                                              DateTime.now();
                                        })
                                      }
                                    : null;
                              });
                            },
                            child: const Row(children: [
                              Icon(Icons.timer),
                              SizedBox(width: 5),
                              Flexible(
                                  child: Text(
                                'Aggiorna data scadenza',
                                overflow: TextOverflow.ellipsis,
                              ))
                            ]))
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(children: [
                          const CustomHeadingTitle(titleText: "Stato"),
                          statusCheck(widget.project)
                        ])),
                    const Text(
                        'Puoi modificare lo stato del progetto (puoi archiviarlo, completarlo o anche eliminarlo se necessario), cliccando su uno dei seguenti pulsanti:'),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.green),
                                    onPressed: widget.project.status == 'Attivo'
                                        ? null
                                        : () async {
                                            DatabaseHelper.instance
                                                .updateStatus(
                                                    widget.project.name,
                                                    "Attivo");
                                            widget.project.status = 'Attivo';
                                            setState(() {});
                                          },
                                    child: const Row(children: [
                                      Icon(Icons.star),
                                      SizedBox(width: 5),
                                      Text('Rendi attivo')
                                    ])),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.red),
                                    onPressed: widget.project.status ==
                                            'Fallito'
                                        ? null
                                        : () async {
                                            showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Motivazione fallimento'),
                                                    content: BlurredBox(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        sigma: 0,
                                                        child: TextField(
                                                          maxLength: 300,
                                                          maxLengthEnforcement:
                                                              MaxLengthEnforcement
                                                                  .enforced,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          decoration:
                                                              const InputDecoration(
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    100,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            filled: true,
                                                            border: OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                            hintText:
                                                                'Inserisci la motivazione del fallimento',
                                                            hintStyle: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        192,
                                                                        192,
                                                                        192)),
                                                          ),
                                                          maxLines: 4,
                                                          controller:
                                                              failureReasonController,
                                                        )),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            widget.project
                                                                    .status =
                                                                'Fallito';
                                                            DatabaseHelper
                                                                .instance
                                                                .updateFailureReason(
                                                                    widget
                                                                        .project
                                                                        .name,
                                                                    failureReasonController
                                                                        .text);
                                                            DatabaseHelper
                                                                .instance
                                                                .updateStatus(
                                                                    widget
                                                                        .project
                                                                        .name,
                                                                    'Fallito');
                                                            widget.project
                                                                    .projectFailureReason =
                                                                failureReasonController
                                                                    .text;
                                                            setState(() {});
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                            'Conferma',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .pink),
                                                          ))
                                                    ],
                                                  );
                                                }));
                                          },
                                    child: const Row(children: [
                                      Icon(Icons.archive),
                                      SizedBox(width: 5),
                                      Text('Archivia come fallito')
                                    ])),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.blue),
                                    onPressed:
                                        widget.project.status == 'Completato'
                                            ? null
                                            : () async {
                                                DatabaseHelper.instance
                                                    .updateStatus(
                                                        widget.project.name,
                                                        "Completato");
                                                widget.project.status =
                                                    'Completato';
                                                DatabaseHelper.instance
                                                    .updateTaskAsCompletedByProjectName(
                                                        widget.project.name);
                                                setState(() {});
                                              },
                                    child: const Row(children: [
                                      Icon(Icons.check_circle),
                                      SizedBox(width: 5),
                                      Text('Archivia come completato')
                                    ])),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.orange),
                                    onPressed: widget.project.status ==
                                            'Sospeso'
                                        ? null
                                        : () async {
                                            DatabaseHelper.instance
                                                .updateStatus(
                                                    widget.project.name,
                                                    "Sospeso");
                                            widget.project.status = 'Sospeso';
                                            setState(() {});
                                          },
                                    child: const Row(children: [
                                      Icon(Icons.block),
                                      SizedBox(width: 5),
                                      Text('Sospendi')
                                    ])),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.red),
                                    onPressed: () async {
                                      DatabaseHelper.instance
                                          .deleteProject(widget.project.name);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Row(children: [
                                      Icon(Icons.delete_forever),
                                      SizedBox(width: 5),
                                      Text('Elimina')
                                    ])),
                              ],
                            ))),
                    widget.project.isFailed()
                        ? Text(
                            'Il progetto è archiviato come fallito per la seguente motivazione: "${widget.project.projectFailureReason}".')
                        : const SizedBox(),
                    const SizedBox(height: 5),
                    const CustomHeadingTitle(titleText: 'Task'),
                    FutureBuilder(
                        future: _loadTasks(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return TasksCheckboxView(
                                tasks: snapshot.data as List<Task>);
                          }
                        }),
                    const Text(
                        'Per aggiungere task modifica il progetto cliccando in alto a destra.')
                  ],
                ),
              ),
            )));
  }
}
