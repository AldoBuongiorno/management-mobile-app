import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';

import '../commonElements/carousel_item.dart';
import '../commonElements/headings_title.dart';
import '../data/database_helper.dart';
import 'teams_page.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});
/*
  Future<List<Project>> _loadProjectsOrderByLastModified() async {
    return await DatabaseHelper.instance.getActiveProjectsOrderedByLastModified(); 
  }

  Future<List<Team>> _TeamsOrderedByMemberCount() async {
    return await DatabaseHelper.instance.getTeamsOrderedByMemberCount(); 
  }*/

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        DatabaseHelper.instance.getActiveProjectsOrderedByLastModified(),
        DatabaseHelper.instance.getTeamsOrderedByMemberCount(),
        
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
              //backgroundColor: Colors.amber,
              body: SingleChildScrollView(
                  child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 20
                          : 100),
                  child: Row(children: [
                    CustomHeadingTitle(titleText: 'Progetti recenti'),
                  ])),
              const SizedBox(height: 10),
              addCarouselIfNotEmpty(
                  snapshot.data?[0] as List<Project>, context),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 20
                          : 100),
                  child: Row(children: [
                    CustomHeadingTitle(titleText: 'Team recenti'),
                  ])),
              const SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 20
                          : 100),
                  child: addTeamsIfNotEmpty(
                      snapshot.data?[1] as List<Team>, context))
            ],
          )));
        }
      },
    );
  }

  Widget addCarouselIfNotEmpty(List testList, BuildContext context) {
    if (testList.isEmpty) {
      return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 20
                    : 100),
        child: const Text('Non ci sono progetti recenti.'),
      );
    } else {
      return CarouselSlider.builder(
        itemCount: testList
            .length /*ProjectList.projectsList
                  .where((element) => element.isActive())
                  .toList()
                  .length <
              ProjectList.projectOnHomepageNumber
          ? ProjectList.projectsList
              .where((element) => element.isActive())
              .toList()
              .length
          : ProjectList.projectOnHomepageNumber*/
        ,
        itemBuilder: (context, index, realIndex) {
          //final urlImage = testList[index];
          Project testItem = testList[index];
          return buildCarousel(index, testItem, context);
        },
        options: CarouselOptions(height: 200),
      );
    }
  }

  Widget addTeamsIfNotEmpty(List testList, BuildContext context) {
    if (testList.isEmpty) {
      return Container(
          alignment: Alignment.centerLeft,
          child: const Text('Non ci sono team recenti.'));
    } else {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: testList
              .length /*testlistProjectList.teamsList.length
                     <
                ProjectList.teamOnHomepageNumber
            ? ProjectList.teamsList.length
            : ProjectList.projectOnHomepageNumber*/
          ,
          itemBuilder: (context, index) {
            return FutureBuilder<List<Member>>(
              future: DatabaseHelper.instance
                  .getMembersByTeam(testList[index].getName()),
              builder: (context, membersSnapshot) {
                if (membersSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Visualizza un indicatore di caricamento durante il caricamento dei membri del team
                } else if (membersSnapshot.hasError) {
                  return Text(
                      'Errore: ${membersSnapshot.error}'); // Gestisci eventuali errori durante il caricamento dei membri del team
                } else {
                  return ExpandableTeamTile(
                      testList[index].getName(), membersSnapshot.data!, index);
                }
              },
            );
          });
    }
  }
}


class ExpandableTeamTile extends StatefulWidget {
  ExpandableTeamTile(this.teamName,this.memberList, this.index, {super.key});
  String teamName;
  List<Member> memberList;
  int index;

  @override
  State<ExpandableTeamTile > createState() => _ExpandableTeamTileState();
}


class _ExpandableTeamTileState extends State<ExpandableTeamTile > {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    //teamList[widget.index].members = memberList;
    return Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
        ),
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: <Widget>[
                ExpansionTile(
                  iconColor: Colors.lightBlue,
                  collapsedIconColor: Colors.pink,
                  expandedAlignment: Alignment.centerLeft,

                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.teamName,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                            ("(${widget.memberList.length} membri)"),
                            style: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 14))
                      ]),
                  //subtitle: Text('Trailing expansion arrow icon'),
                  children: [
                    for (Member member 
                        in widget.memberList)
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 30, bottom: 5),
                          child: Text('${member.name} ${member.surname}'))
                  ]
                ),
              ],
            )));
  }

}
