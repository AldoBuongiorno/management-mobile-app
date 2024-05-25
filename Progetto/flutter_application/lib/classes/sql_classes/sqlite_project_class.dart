import 'package:flutter/material.dart';
import 'package:flutter_application/classes/sql_classes/sqlite_team_class.dart';

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