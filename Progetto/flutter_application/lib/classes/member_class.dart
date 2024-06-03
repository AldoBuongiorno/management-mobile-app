import 'package:flutter_application/classes/all.dart';

class Member {
  
  int? code;
  String name;
  String surname;
  String role;
  Team? mainTeam;
  Team? secondaryTeam;

  int? getCode() {
    return code;
  }

  String getMemberName() {
    return name;
  }
  
  String getMemberSurname() {
    return surname;
  }

  String getMemberRole() {
    return role;
  }

  bool isFree() {
    return mainTeam == null || secondaryTeam == null;
  }

  @override
  bool operator == (Object other) {
    if (other is Member) {
      return code == other.code;
    }
    return false;
  }


  Member({
    this.code,
    required this.name,
    required this.surname,
    required this.role,
    this.mainTeam,
    this.secondaryTeam,
  });

  Map<String, dynamic> toMap() {
    return {
      //'code': code,
      'name': name,
      'surname': surname,
      'role': role,
      'mainTeam': mainTeam?.getName(),
      'secondaryTeam': secondaryTeam?.getName(),
    };
  }

  @override
  String toString() {
    return 'Member{code: $code, name: $name, surname: $surname, role: $role, mainTeam: $mainTeam, secondaryTeam: $secondaryTeam}';
  }


}