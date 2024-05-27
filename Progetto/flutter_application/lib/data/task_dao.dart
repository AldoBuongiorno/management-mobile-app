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

  Future<List<Task>> getAllTasks() async {
  final db = await DatabaseHelper.instance.database;
  final List<Map<String, dynamic>> maps = await db.query('Task');

  return Future.wait(maps.map((map) async {
    final projectName = map['project']; // Ottieni il nome del progetto
    final project = await ProjectDao.instance.getProjectByName(projectName); // Ottieni l'oggetto Project associato
    return Task.fromMap(map, project);
  }).toList());
}



}
