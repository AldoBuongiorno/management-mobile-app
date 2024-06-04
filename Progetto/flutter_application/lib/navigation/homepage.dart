import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';

import '../classes/setting_class.dart';
import '../commonElements/carousel_item.dart';
import '../commonElements/headings_title.dart';
import '../data/database_helper.dart';
import 'add_page.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => HomePageScreenState();
}

class HomePageScreenState extends State<HomePageScreen> {
  HomePageScreenState();
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
        DatabaseHelper.instance.getSettings(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
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
                      horizontal: MediaQuery.of(context)
                                  .orientation == //il margine orizzontale dipende dall'orientamento del dispositivo
                              Orientation.portrait
                          ? 20
                          : 100),
                  child: Row(children: [
                    CustomHeadingTitle(titleText: 'Progetti recenti'),
                  ])),
              const SizedBox(height: 20),
              addCarouselIfNotEmpty(
                snapshot.data?[0] as List<Project>,
                snapshot.data![2],
                context,
              ),
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
                    snapshot.data?[1] as List<Team>,
                    snapshot.data![2],
                    context,
                  ))
            ],
          )));
        }
      },
    );
  }

  Widget addCarouselIfNotEmpty(
      List<Project> list, List<Setting> settings, BuildContext context) {
    //testList.insert(0, Project(name: '', description: '', team: Team(name: '', thumbnail: const AssetImage('')), thumbnail: const AssetImage('')));
    if (list.isEmpty) {
      return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 20
                    : 100),
        child: GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondRoute(),
                      ),
                    ).then((_) => setState(() {})),
                child: Container( height: 200,
                    decoration: BoxDecoration(
                      
                        //color: Colors.transparent,
                        border: Border.all(
                            width: 4,
                            color: Colors.white), //155
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Center(
                        child: Icon(
                      Icons.add_circle_outline_sharp,
                      size: 75,
                      color: Colors.white,
                    ))))
        //const Text('Non ci sono progetti recenti.'),
      );
    } else {
      return CarouselSlider.builder(
        itemCount: list.length + 1 < settings[0].number + 1
            ? list.length + 1
            : settings[0].number + 1
        ,
        itemBuilder: (context, index, realIndex) {
          if (index - 1 == -1) {
            //testList.removeAt(0);

            return GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondRoute(),
                      ),
                    ).then((_) => setState(() {})),
                child: Container(
                    decoration: BoxDecoration(
                      
                        //color: Colors.transparent,
                        border: Border.all(
                            width: 4,
                            color: Colors.white), //155
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Center(
                        child: Icon(
                      Icons.add_circle_outline_sharp,
                      size: 75,
                      color: Colors.white,
                    ))));
          } else {
            Project testItem = list[index - 1];
            return buildCarousel(index - 1, testItem, context);
          }
        },
        options: CarouselOptions(
            height: 200, enableInfiniteScroll: false, initialPage: 1),
      );
    }
  }

  Widget addTeamsIfNotEmpty(List<Team> list, List<Setting> settings,BuildContext context) {
    
    if (list.isEmpty) {
      return Container(
          alignment: Alignment.centerLeft,
          child: const Text('Non ci sono team recenti.'));
    } else {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length < settings[1].number
            ? list.length 
            : settings[1].number
          ,
          itemBuilder: (context, index) {
            Team testItem = list[index];
            return ExpandableTeamTile(testItem.getName(), index);
          });
    }
  }
}

class ExpandableTeamTile extends StatefulWidget {
  final String teamName;
  final int index;

  const ExpandableTeamTile(this.teamName, this.index, {super.key});

  @override
  State<ExpandableTeamTile> createState() => _ExpandableTeamTileState();
}

class _ExpandableTeamTileState extends State<ExpandableTeamTile> {
  late Future<List<Member>> _membersFuture;

  @override
  void initState() {
    super.initState();
    _membersFuture = DatabaseHelper.instance.getMembersByTeam(widget.teamName);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent,
        
      ),
      child: Container(
        
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          
          iconColor: Colors.lightBlue,
          collapsedIconColor: Colors.pink,
          expandedAlignment: Alignment.centerLeft,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(overflow: TextOverflow.ellipsis,
                widget.teamName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              )),
              FutureBuilder<List<Member>>(
                future: _membersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Errore: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return Flexible(child: Text(overflow: TextOverflow.fade,
                      "(${snapshot.data!.length} membri)",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
          children: [
            FutureBuilder<List<Member>>(
              future: _membersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Column(
                    children: snapshot.data!.map((member) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 30, bottom: 10),
                        child: Text('${member.name} ${member.surname}'),
                      );
                    }).toList(),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
