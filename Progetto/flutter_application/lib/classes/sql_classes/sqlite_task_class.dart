import 'package:flutter_application/classes/sql_classes/sqlite_project_class.dart';

class Task {

  String name;
  bool completed = false;
  Project project;

  double progress = 0; //boh

  bool isCompleted() {
    return completed;
  }

  void completeTask() {
    completed = true;
  }

  Task(this.name, this.project);
}