import 'package:sqflite/sqflite.dart';
import 'package:flutter_application/classes/sql_classes/sqlite_class_all.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'package:flutter_application/data/project_dao.dart';

class TaskDao {
  TaskDao._privateConstructor();
  static final TaskDao instance = TaskDao._privateConstructor();

  Future<void> insertTask(Task task) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'Task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}
