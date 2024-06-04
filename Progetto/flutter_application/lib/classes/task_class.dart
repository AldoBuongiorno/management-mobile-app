import 'package:flutter_application/classes/all.dart';

class Task {
  String name;
  bool? completed;
  Project? project;

  String getName() {
    return name;
  }

  bool? getCompleted() {
    return completed;
  }


  void setProject(Project project) {
    this.project = project;
  }
  

  Task({
    required this.name,
    this.completed,
    this.project,
  }) {
    completed ??= false;
  }


  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'completed': (completed ?? false) ? 1 : 0,
      'project': project?.getName(),
    };
  }

  @override
  String toString() {
    return 'Task{name: $name, completed: $completed, project: $project}';
  }


}