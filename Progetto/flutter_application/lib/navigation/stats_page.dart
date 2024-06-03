import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'routes/create_member_route.dart';
import 'routes/create_project_route.dart';
import 'package:input_quantity/input_quantity.dart';
import '../data/project_list.dart';
import 'routes/create_team_route.dart';
import '../commonElements/responsive_padding.dart';
import '../commonElements/blurred_box.dart';
import 'package:flutter_application/classes/all.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Statistiche Team',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Numero di team: 123'),
                Text('Numero medio membri team: 456'),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.grey[350], // Sfondo grigio chiaro
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Statistiche Progetti',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Numero di progetti: 123'),
                Text('Numero di progetti completati con successo: 456'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


