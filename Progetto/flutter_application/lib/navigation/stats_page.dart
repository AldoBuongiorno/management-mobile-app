import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import 'package:flutter_application/data/database_helper.dart';
import '../commonElements/responsive_padding.dart';
import '../commonElements/blurred_box.dart';
import 'package:flutter_application/classes/all.dart';

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

  Future<int> _loadNumProjects() async {
    final int numProjects = await DatabaseHelper.instance.getNumProjects();
    return numProjects;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getResponsivePadding(context),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal:
                      MediaQuery.of(context).orientation == Orientation.portrait
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
                Text('Numero medio membri team: 456'),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    Text('Numero di progetti completati con successo: 456'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
