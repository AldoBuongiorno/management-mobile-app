import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';
import 'package:flutter_application/data/database_helper.dart';


class ProjectList {

  static int projectOnHomepageNumber = 5;
  static int teamOnHomepageNumber = 5;
  static List<Task> tasksList = [];
  static List<Team> teamsList = [];
  static List<Project> projectsList = [];
  static List<Member> membersList = [];
  static List<AssetImage> thumbnailsList = List.from(<AssetImage>[const AssetImage('assets/images/projectPreview/default.jpg'), const AssetImage('assets/images/projectPreview/architectural.jpg'), const AssetImage('assets/images/projectPreview/baking.jpg'), const AssetImage('assets/images/projectPreview/engineering.jpg'), const AssetImage('assets/images/projectPreview/safety.jpg'), const AssetImage('assets/images/projectPreview/studying.jpg')]);

  static Team team1 = Team(name: "Team 1");
  static Team team2 = Team(name: "Team 2");
  static Team team3 = Team(name: "Team 3");
  static Member member1 = Member(code: 1, name: "Mario", surname: "Rossi", role: "Direttore", mainTeam: team1 , secondaryTeam: team3);
  static Member member2 = Member(code: 2, name: "Luigi", surname: "Bianchi", role: "Operaio", mainTeam: team1 , secondaryTeam: team2);
  static Member member3 = Member(code: 3, name: "Carla", surname: "Verdi", role: "Supervisore", mainTeam: team2);

  static Project project1 = Project(name: "Mobile Programming",description: "Boh",team: team1, thumbnail: const AssetImage('assets/images/projectPreview/architectural.jpg'));
  static Project project2 = Project(name: "Basi di Dati",description: "Boh",team: team2, thumbnail: const AssetImage('assets/images/projectPreview/engineering.jpg'));
  static Project project3 = Project(name: "Statistica",description: "Boh",team: team2, thumbnail: const AssetImage('assets/images/projectPreview/safety.jpg'));
  static Project project4 = Project(name: "IOT",description: "Boh",team: team3, thumbnail: const AssetImage('assets/images/projectPreview/baking.jpg'));
  static Project project5 = Project(name: "Intelligenza Artificiale",description: "Boh",team: team3, thumbnail: const AssetImage('assets/images/projectPreview/default.jpg'));

  List<Team> getTeam() {
    return teamsList;
  }

  List<AssetImage> getThumbnailList() {
    return thumbnailsList;
  }

  List<Project> getList() {
    return projectsList;
  }

  List<Task> getTaskList() {
    return tasksList;
  }

  List<Member> getMembersList() {
    return membersList;
  }

  List<Project> getProjectsList() {
    return projectsList;
  }

  Future<void> loadSampleData() async {
  await DatabaseHelper.instance.insertTeam(team1);
  await DatabaseHelper.instance.insertTeam(team2);
  await DatabaseHelper.instance.insertTeam(team3);
  await DatabaseHelper.instance.insertProject(project1);
  await DatabaseHelper.instance.insertProject(project2);
  await DatabaseHelper.instance.insertProject(project3);
  await DatabaseHelper.instance.insertProject(project4);
  await DatabaseHelper.instance.insertProject(project5);
  await DatabaseHelper.instance.insertMember(member1);
  await DatabaseHelper.instance.insertMember(member2);
  await DatabaseHelper.instance.insertMember(member3);

/*
  tasksList = await DatabaseHelper.instance.getTasks();
  teamsList = await DatabaseHelper.instance.getTeams();
  projectsList = await DatabaseHelper.instance.getProjects();
  membersList = await DatabaseHelper.instance.getMembers();*/
  }

}

