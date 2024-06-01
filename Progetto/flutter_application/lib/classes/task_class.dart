import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';

class Task {
  String name;
  DateTime? completationDate;
  bool? completed;
  double? progress;
  Project? project;

  void setProject(Project newProject) {
    project = newProject;
  }

  String getName() {
    return name;
  }

  bool? getCompleted() {
    return completed;
  }

  double? getProgress() {
    return progress;
  }

  Task({
    required this.name,
    this.completationDate,
    this.completed,
    this.progress,
    required this.project,
  }) {
    completed ??= false;
    progress ??= 0;
  }


  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'completationDate': completationDate?.toIso8601String(),
      'completed': (completed ?? false) ? 1 : 0,
      'progress': completed,
      'project': project?.getName(),
    };
  }

  @override
  String toString() {
    return 'Task{name: $name, creationDate: $completationDate, completed: $completed, progress: $progress, project: $project}';
  }


}