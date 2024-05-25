import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';

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