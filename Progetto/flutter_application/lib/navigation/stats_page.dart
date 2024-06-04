import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'package:intl/intl.dart';
import '../commonElements/responsive_padding.dart';
import '../commonElements/blurred_box.dart';
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
    }
    if(sum == 0){
      return 0;
    }else{
      return (sum / numMembersPerTeam.length).round();
    }
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          width: 20,
          height: 20,
          //color: color,
          margin: const EdgeInsets.only(right: 5),
        ),
        //Flexible(child:
        Text(
          text,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics()
          .applyTo(const BouncingScrollPhysics()),
      child: Container(
        margin: getResponsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeadingTitle(titleText: 'Statistiche generali'),
            const SizedBox(height: 10),
            BlurredBox(
                borderRadius: BorderRadius.circular(20),
                sigma: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  //margin: const EdgeInsets.symmetric(vertical: 10),
                  color:
                      const Color.fromARGB(25, 0, 0, 0), // Sfondo grigio chiaro
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Statistiche Team',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<int>(
                        future: _loadNumTeams(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Errore: ${snapshot.error}'));
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Errore: ${snapshot.error}'));
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
                )),
            const SizedBox(height: 10),
            BlurredBox(
                borderRadius: BorderRadius.circular(20),
                sigma: 15,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  //margin: const EdgeInsets.symmetric(vertical: 10),
                  color:
                      const Color.fromARGB(25, 0, 0, 0), // Sfondo grigio chiaro
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
                      const SizedBox(height: 10),
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
                                return Text(
                                    'Numero di progetti: ${snapshot.data}');
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            spacing: 20,
                            direction: Axis.horizontal,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          const SizedBox(height: 10),
                          Wrap(
                            alignment: WrapAlignment.spaceAround,
                            spacing: 20,
                            direction: Axis.horizontal,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          const SizedBox(height: 15),
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
                )),
                const SizedBox(height: 5,),
            FutureBuilder(
              future: DatabaseHelper.instance.getProjects(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Errore: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding:
                              const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].name, style: const TextStyle(fontWeight: FontWeight.bold),),
                                  Text('Creato ${DateTime.now().difference(snapshot.data![index].creationDate!).inDays} giorni fa.'),
                                ],
                              ),
                              FutureBuilder(
                                  future: snapshot.data![index].getProgress(),
                                  builder: (context, taskSnapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: Text(
                                              'Errore: ${snapshot.error}'));
                                    } else {
                                      return Text('${taskSnapshot.data}%', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),);
                                    }
                                  })
                            ],
                          ),
                        );
                      }));
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
