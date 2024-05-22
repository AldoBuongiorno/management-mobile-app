import 'package:flutter/material.dart';

import '../projectItems.dart';


Member member1 = Member("Mario", "Rossi", "Direttore");
  Member member2 = Member("Luigi", "Bianchi", "Operaio");
  Member member3 = Member("Carla", "Verdi", "Supervisore");
  Team team1 = Team("Team 1", List<Member>.from(<Member>[member1, member2]));
  Team team2 = Team("Team 2", List<Member>.from(<Member>[member3, member2]));
  Team team3 = Team("Team 3", List<Member>.from(<Member>[member1]));

List<Task> taskList = List.empty(growable: true);
List<Team> teamsList = List.from(<Team>[team1, team2, team3]);
List<ProjectItem> testList = populateTestList();
List<Member> memberList = List.empty(growable: true);
List<AssetImage> thumbnailList = List.from(<AssetImage>[AssetImage('assets/images/projectPreview/default.jpg'), AssetImage('assets/images/projectPreview/architectural.jpg'), AssetImage('assets/images/projectPreview/baking.jpg'), AssetImage('assets/images/projectPreview/engineering.jpg'), AssetImage('assets/images/projectPreview/safety.jpg'), AssetImage('assets/images/projectPreview/studying.jpg')]);

class ProjectList {
  List<Team> getTeam() {
    return teamsList;
  }

  List<AssetImage> getThumbnailList() {
    return thumbnailList;
  }

  List<ProjectItem> getList() {
    return testList;
  }

  List<Task> getTaskList() {
    return taskList;
  }

  List<Member> getMembersList() {
    return memberList;
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

  ProjectItem project1 =
      ProjectItem("Mobile Programming", "Boh", "Attivo", team1);
  ProjectItem project2 = ProjectItem("Basi di Dati", "Boh", "Attivo", team2);
  ProjectItem project3 = ProjectItem("Statistica", "Boh", "Sospeso", team2);
  ProjectItem project4 = ProjectItem("IOT", "Boh", "Archiviato", team3);
  ProjectItem project5 =
      ProjectItem("Intelligenza Artificiale", "Boh", "Archiviato", team3);

  project1.preview = AssetImage('assets/images/projectPreview/architectural.jpg');
  project2.preview = AssetImage('assets/images/projectPreview/engineering.jpg');
  project3.preview = AssetImage('assets/images/projectPreview/safety.jpg');
  project4.preview = AssetImage('assets/images/projectPreview/baking.jpg');
  project5.preview = AssetImage('assets/images/projectPreview/default.jpg');

  return List<ProjectItem>.from(
      <ProjectItem>[project1, project2, project3, project4, project5]);
}

