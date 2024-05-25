import 'package:flutter/material.dart';

import '../commonElements/project_items.dart';


Member member1 = Member("Mario", "Rossi", "Direttore");
Member member2 = Member("Luigi", "Bianchi", "Operaio");
Member member3 = Member("Carla", "Verdi", "Supervisore");
Team team1 = Team("Team 1", List<Member>.from(<Member>[member1, member2]));
Team team2 = Team("Team 2", List<Member>.from(<Member>[member3, member2]));
Team team3 = Team("Team 3", List<Member>.from(<Member>[member1]));



class ProjectList {

static int projectOnHomepageNumber = 5;
static int teamOnHomepageNumber = 5;

// liste contenenti i dati utilizzati dall' app; sono istanziate con valori a caso per prova
static List<Task> tasksList = [];
static List<Team> teamsList = [];
static List<ProjectItem> projectsList = [];
static List<Member> membersList = [];
static List<AssetImage> thumbnailsList = List.from(<AssetImage>[const AssetImage('assets/images/projectPreview/default.jpg'), const AssetImage('assets/images/projectPreview/architectural.jpg'), const AssetImage('assets/images/projectPreview/baking.jpg'), const AssetImage('assets/images/projectPreview/engineering.jpg'), const AssetImage('assets/images/projectPreview/safety.jpg'), const AssetImage('assets/images/projectPreview/studying.jpg')]);

  List<Team> getTeam() {
    return teamsList;
  }

  List<AssetImage> getThumbnailList() {
    return thumbnailsList;
  }

  List<ProjectItem> getList() {
    return projectsList;
  }

  List<Task> getTaskList() {
    return tasksList;
  }

  List<Member> getMembersList() {
    return membersList;
  }
  //List<ProjectItem> testList = populateTestList();
}

List<ProjectItem> populateTestList() {
  Member member1 = Member("Mario", "Rossi", "Direttore");
  Member member2 = Member("Luigi", "Bianchi", "Operaio");
  Member member3 = Member("Carla", "Verdi", "Supervisore");
  Team team1 = Team("Team 1", List<Member>.from(<Member>[member1, member2]));
  Team team2 = Team("Team 2", List<Member>.from(<Member>[member3, member2]));
  Team team3 = Team("Team 3", List<Member>.from(<Member>[member1]));

  ProjectItem project1 = ProjectItem("Mobile Programming", "Boh", "Attivo", team1);
  ProjectItem project2 = ProjectItem("Basi di Dati", "Boh", "Attivo", team2);
  ProjectItem project3 = ProjectItem("Statistica", "Boh", "Sospeso", team2);
  ProjectItem project4 = ProjectItem("IOT", "Boh", "Archiviato", team3);
  ProjectItem project5 = ProjectItem("Intelligenza Artificiale", "Boh", "Completato", team3);

  project1.thumbnail = const AssetImage('assets/images/projectPreview/architectural.jpg');
  project2.thumbnail = const AssetImage('assets/images/projectPreview/engineering.jpg');
  project3.thumbnail = const AssetImage('assets/images/projectPreview/safety.jpg');
  project4.thumbnail = const AssetImage('assets/images/projectPreview/baking.jpg');
  project5.thumbnail = const AssetImage('assets/images/projectPreview/default.jpg');

  return List<ProjectItem>.from(
      <ProjectItem>[project1, project2, project3, project4, project5]);
}

