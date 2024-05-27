import 'package:sqflite/sqflite.dart';
import 'package:flutter_application/classes/sql_classes/sqlite_class_all.dart';
import 'package:flutter_application/data/database_helper.dart';

class ProjectDao {
  ProjectDao._privateConstructor();
  static final ProjectDao instance = ProjectDao._privateConstructor();

  Future<void> insertProject(Project project) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'Project',
      project.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Project>> getAllProjects() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('Project');

    return List.generate(maps.length, (i) {
      return Project.fromMap(maps[i]);
    });
  }

  Future<Project> getProjectByName(String projectName) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Project',
      where: 'name = ?',
      whereArgs: [projectName],
    );

    if (maps.isNotEmpty) {
      return Project.fromMap(maps.first);
    } else {
      throw Exception('Project not found');
    }
  }
}
