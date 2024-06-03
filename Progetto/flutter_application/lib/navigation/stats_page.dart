import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import 'package:flutter_application/data/database_helper.dart';
import '../commonElements/responsive_padding.dart';
import '../commonElements/blurred_box.dart';
import 'package:flutter_application/classes/all.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  Future<int> _loadNumTeams() async {
    final int numTeams = await DatabaseHelper.instance.getNumTeams();
    return numTeams;
  }

  Future<int> _loadAvgNumMembersPerTeam() async {
    final List<int> numMembersPerTeam =
        await DatabaseHelper.instance.getAvgNumMembersPerTeam();
    int sum = 0;
    for (final num in numMembersPerTeam) {
      sum += num;
      print(num);
    }
    return (sum / numMembersPerTeam.length).round();
  }

  Future<int> _loadNumProjects() async {
    final int numProjects = await DatabaseHelper.instance.getNumProjects();
    return numProjects;
  }

  Future<List<double>> _loadProjectsStatus() async {
    final List<double> projectsStatus =
        await DatabaseHelper.instance.getStatusProjects();
    return projectsStatus;
  }

  Widget _buildLegendItem({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
          margin: EdgeInsets.only(right: 5),
        ),
        Text(text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: getResponsivePadding(context),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 20
                        : 100),
                child: Row(children: [
                  CustomHeadingTitle(titleText: 'Statistiche generali'),
                ])),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.grey[350], // Sfondo grigio chiaro
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Statistiche Team',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder<int>(
                    future: _loadNumTeams(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Errore: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return Text('Numero di team: ${snapshot.data}');
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  FutureBuilder<int>(
                    future: _loadAvgNumMembersPerTeam(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Errore: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return Text(
                            'Numero medio di membri per team: ${snapshot.data}');
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.grey[350], // Sfondo grigio chiaro
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Statistiche Progetti',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<int>(
                        future: _loadNumProjects(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Errore: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            return Text('Numero di progetti: ${snapshot.data}');
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLegendItem(
                            color: Colors.green,
                            text: 'Attivi',
                          ),
                          _buildLegendItem(
                            color: Colors.blue,
                            text: 'Completati',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLegendItem(
                            color: Colors.red,
                            text: 'Falliti',
                          ),
                          _buildLegendItem(
                            color: Colors.orange,
                            text: 'Sospesi',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<List<double>>(
                        future: _loadProjectsStatus(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Errore: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).orientation ==
                                              Orientation.portrait
                                          ? 25
                                          : 100),
                              height: 200,
                              width: 300,
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      color: Colors.green,
                                      value: snapshot.data?[0],
                                      title: '${snapshot.data?[0].toInt()}',
                                    ),
                                    PieChartSectionData(
                                      color: Colors.blue,
                                      value: snapshot.data?[1],
                                      title: '${snapshot.data?[1].toInt()}',
                                    ),
                                    PieChartSectionData(
                                      color: Colors.red,
                                      value: snapshot.data?[2],
                                      title: '${snapshot.data?[2].toInt()}',
                                    ),
                                    PieChartSectionData(
                                      color: Colors.orange,
                                      value: snapshot.data?[3],
                                      title: '${snapshot.data?[3].toInt()}',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
