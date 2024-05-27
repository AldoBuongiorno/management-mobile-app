import 'package:sqflite/sqflite.dart';
import 'package:flutter_application/classes/sql_classes/sqlite_class_all.dart';
import 'package:flutter_application/data/database_helper.dart';

class TeamDao {
  TeamDao._privateConstructor();
  static final TeamDao instance = TeamDao._privateConstructor();

  Future<void> insertTeam(Team team) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'Team',
      team.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Team>> getAllTeams() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('Team');

    return List.generate(maps.length, (i) {
      return Team.fromMap(maps[i]);
    });
  }

}
