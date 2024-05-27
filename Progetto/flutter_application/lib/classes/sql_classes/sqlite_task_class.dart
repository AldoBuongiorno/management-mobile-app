import 'package:flutter_application/classes/sql_classes/sqlite_class_all.dart';

class Task {
  final String name;
  bool completed = false;
  final Project project;

  Task({
    required this.name,
    required this.completed,
    required this.project,
  });

  String getName() {
    return name;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'completed': completed ? 1 : 0,
      'project': project.getName(),
    };
  }

  @override
  String toString() {
    return 'Task{name: $name, completed: $completed, project: $project}';
  }

}

/*
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
*/