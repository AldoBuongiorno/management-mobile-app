import 'package:flutter_application/classes/sql_classes/sqlite_team_class.dart';

class Member {

  String code;

  String name;
  String surname;

  String role;

  Team? mainTeam;
  Team? secondaryTeam; 

  Member(this.code, this.name, this.surname, this.role);
}