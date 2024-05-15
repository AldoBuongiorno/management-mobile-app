
class Project {
  String name;
  String description;
  String status;

  late DateTime completionDate;
  Team team;

  bool finished = false;

  Project(this.name, this.description, this.status, this.team);
  
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