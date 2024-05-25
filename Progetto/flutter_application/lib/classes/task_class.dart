import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';

class Task {
  String taskName;
  late DateTime completionDate;
  bool finished = false;
  double progress = 0;

  Task(this.taskName);
}