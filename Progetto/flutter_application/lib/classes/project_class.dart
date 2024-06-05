
import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';
import '../data/database_helper.dart';

class Project {

  String name;
  String description;
  DateTime? creationDate;
  DateTime? expirationDate;
  DateTime? lastModified;
  String? status;
  String? projectFailureReason;
  Team? team;
  AssetImage thumbnail;

  Future<double> getProgress() async {
    List<Task> tasksList = await DatabaseHelper.instance.getTasksByProjectName(name);
    double progress = 0; int completedTasks = 0;
    for(Task task in tasksList) {
      if(task.completed!) completedTasks++;
    }
    // x : 100 = completedTasks : tasksList.length;
    progress = (completedTasks * 100)/tasksList.length;

  
<<<<<<< Updated upstream
    return !progress.isNaN  ? progress : 0.0;
=======
    return !progress.isNaN ? ((progress*100).round()/100): 0.0;
>>>>>>> Stashed changes

  }

  bool isActive() {
    return status == "Attivo" ? true : false;
  }

  bool isSuspended() {
    return status == "Sospeso" ? true : false;
  }

  bool isFailed() {
    return status == "Fallito" ? true : false;
  }

  bool isCompleted() {
    return status == "Completato" ? true : false;
  }

  bool isArchived() {
    return status == "Archiviato" ? true : false;
  }

  String getName() {
    return name;
  }

  String getDescription() {
    return description;
  }

  DateTime? getCreationDate() {
    return creationDate;
  }

  DateTime? getExpirationDate() {
    return expirationDate;
  }

  DateTime? getLastModified() {
    return lastModified;
  }

  String? getProjectFailureReason() {
    return projectFailureReason;
  }

  Team? getTeam() {
    return team;
  }
  
  String? getStatus() {
    return status;
  }

  AssetImage getThumbnail() {
    return thumbnail;
  }

  Project({
    required this.name,
    required this.description,
    this.creationDate,
    this.expirationDate,
    this.lastModified,
    this.status,
    this.projectFailureReason,
    required this.team,
    required this.thumbnail,
  }) {
    creationDate ??= DateTime.now();
    expirationDate ??= DateTime.now().add(const Duration(days: 60));
    lastModified ??= DateTime.now();
    status ??= "Attivo";
  }
  

   Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'creationDate': creationDate?.toIso8601String(),
      'expirationDate': expirationDate?.toIso8601String(),
      'lastModified': lastModified?.toIso8601String(),
      'status': status,
      'projectFailureReason': projectFailureReason,
      'team': team?.getName(),
      'thumbnail': thumbnail.assetName,
    };
  }

  @override
  String toString() {
    return 'Project{name: $name, description: $description, creationDate: $creationDate, expirationDate: $expirationDate, lastModified: $lastModified, status: $status, projectFailureReason: $projectFailureReason, team: $team, ${(thumbnail).assetName}}';
  }

}