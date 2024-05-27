import 'package:flutter_application/classes/sql_classes/sqlite_class_all';

class Team {
  final String name;

  Team({required this.name});

  String getName() {
    return name;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      name: map['name'],
    );
  }

  @override
  String toString() {
    return 'Team{name: $name}';
  }
}


/*
class Team {

String name;

Team(this.name);
}
*/