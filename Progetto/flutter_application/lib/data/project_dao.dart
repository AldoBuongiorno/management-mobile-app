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

}
