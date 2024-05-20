
import 'package:flutter/material.dart';

class ProjectItem {
  String name;
  String description;
  String status;

  late DateTime completionDate;
  Team mainTeam;
  late Team secondaryTeam;

  bool finished = false;

  void setStatus(String status) {
    if(status == 'Completato') finished = true;
    this.status = status;
  }

  late AssetImage preview;

  ProjectItem(this.name, this.description, this.status, this.mainTeam);

  String toString() {
    return name + '\n' + description;
  }
  
}

class Team {
  String teamName;
  List<Member> members;

  Team(this.teamName, this.members);
}

class Member {
  String name;
  String surname;
  String role;

  Member(this.name, this.surname, this.role);
}

class Task {
  String taskName;
  late DateTime completionTime;
  bool finished = false;
  double progress = 0;

  Task(this.taskName);
}