import 'package:flutter_application/classes/sql_classes/sqlite_class_all';

class Member {
  final int code;
  final String name;
  final String surname;
  String role;
  Team? mainTeam;
  Team? secondaryTeam;

  Member({
    required this.code,
    required this.name,
    required this.surname,
    required this.role,
    required this.mainTeam,
    required this.secondaryTeam,
  });

  int getCode() {
    return code;
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'surname': surname,
      'role': role,
      'mainTeam': mainTeam?.getName(),
      'secondaryTeam': secondaryTeam?.getName(),
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      code: map['code'],
      name: map['name'],
      surname: map['surname'],
      role: map['role'],
      mainTeam: Team(name: map['mainTeam']),
      secondaryTeam: Team(name: map['secondaryTeam']),
    );
  }

  @override
  String toString() {
    return 'Member{code: $code, name: $name, surname: $surname, role: $role, mainTeam: $mainTeam, secondaryTeam: $secondaryTeam}';
  }
}


/*
class Member {

  String code;
  String name;
  String surname;
  String role;
  Team? mainTeam;
  Team? secondaryTeam; 

  Member(this.code, this.name, this.surname, this.role);
}
*/