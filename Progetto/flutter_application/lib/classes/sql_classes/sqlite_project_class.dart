import 'package:flutter/material.dart';
import 'package:flutter_application/classes/sql_classes/sqlite_class_all.dart';

class Project {
  final String name;
  final String description;
  DateTime creationDate = DateTime.now();
  DateTime expirationDate = DateTime.now().add(const Duration(days: 60)); //di default la scadenza è a due mesi (60gg) dalla creazione;
  DateTime lastModified = DateTime.now();
  String status = "Attivo";
  final String? projectFailureReason;
  final Team team;
  final String thumbnail;

  Project({
    required this.name,
    required this.description,
    required this.creationDate,
    required this.expirationDate,
    required this.lastModified,
    required this.status,
    required this.projectFailureReason,
    required this.team,
    required this.thumbnail,
  });

  String getName() {
    return name;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'creationDate': creationDate.toIso8601String(),
      'expirationDate': expirationDate.toIso8601String(),
      'lastModified': lastModified.toIso8601String(),
      'status': status,
      'projectFailureReason': projectFailureReason,
      'team': team.getName(),
      'thumbnail': thumbnail,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      name: map['name'],
      description: map['description'],
      creationDate: DateTime.parse(map['creationDate']),
      expirationDate: DateTime.parse(map['expirationDate']),
      lastModified: DateTime.parse(map['lastModified']),
      status: map['status'],
      projectFailureReason: map['projectFailureReason'],
      team: Team(name: map['team']),
      thumbnail: map['thumbnail'],
    );
  }

  @override
  String toString() {
    return 'Project{name: $name, description: $description, creationDate: $creationDate, expirationDate: $expirationDate, lastModified: $lastModified, status: $status, projectFailureReason: $projectFailureReason, team: $team, thumbnail: $thumbnail}';
  }
}

/*
class Project {

  String name;
  String description;

  DateTime creationDate = DateTime.now();
  DateTime lastModified = DateTime.now();
  DateTime expirationDate = DateTime.now().add(Duration(days: 60)); //di default la scadenza è a due mesi (60gg) dalla creazione

  String status = 'Attivo';
  String projectFailureReason = '';
  
  Team team;
  AssetImage thumbnail;

  Project(this.name, this.description, this.team, this.thumbnail);
}
*/