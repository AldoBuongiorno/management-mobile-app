
import 'package:flutter/material.dart';

class ProjectItem {
  String name;
  String description;
  String status;

  late DateTime completionDate;
  DateTime startDate = DateTime.now();
  Team team;
  //late Team secondaryTeam;

  bool finished = false;

  void setStatus(String status) {
    if(status == 'Completato') finished = true;
    this.status = status;
  }

  bool isActive() {
    return status == "Attivo" ? true : false;
  }

  late AssetImage thumbnail;
  late List<Task> tasks = List.empty(growable: true);

  ProjectItem(this.name, this.description, this.status, this.team);

  @override
  String toString() {
    return '$name $description';
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

  String getMemberName() {
    return name;
  }

  bool exists(Member otherMember) {
    
    if(this.name.toLowerCase() == otherMember.name.toLowerCase() &&
    this.surname.toLowerCase() == otherMember.surname.toLowerCase() &&
    this.role.toLowerCase() == otherMember.role.toLowerCase()) return true;
    return false;
  }

  

  Member(this.name, this.surname, this.role);
}

class Task {
  String taskName;
  late DateTime completionDate;
  bool finished = false;
  double progress = 0;

  Task(this.taskName);
}