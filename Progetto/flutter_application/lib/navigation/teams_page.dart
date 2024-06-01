import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/responsive_padding.dart';
import 'package:flutter_application/data/database_helper.dart';
import '../commonElements/blurred_box.dart';
import '../commonElements/headings_title.dart';
import 'package:flutter_application/classes/all.dart';

//List<Member> memberList = getMembersList(); //.add(Member("Mario", "Rossi", "Impiegato"));

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});
  @override
  @override
  State<TeamScreen> createState() => _TeamScreen();
}

class _TeamScreen extends State<TeamScreen> {
  List<Team> filteredList = [];

  Future<List<Team>> _loadTeams() async {
    return await DatabaseHelper.instance.getTeams(); 
  }

  Future<List<Member>> _loadMembersByTeam(String team) async {
    return await DatabaseHelper.instance.getMembersByTeam(team); 
  }
  
  final filterProjectListController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: getResponsivePadding(context),
        child: Column(children: [
          BlurredBox(
              borderRadius: BorderRadius.circular(30),
              sigma: 5,
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: filterProjectListController,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    filled: true,
                    fillColor: Color.fromARGB(100, 0, 0, 0),
                    suffixIcon: Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                        //borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Cerca team...',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
                onChanged: toFilteredList,
              )),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(future: _loadTeams(), builder: (BuildContext context, AsyncSnapshot<List<Team>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return 
          filteredList.isNotEmpty || filterProjectListController.text.isNotEmpty
              ? buildTeamContainer(filteredList)
              : //buildProjectContainer(snapshot.data!); 
                Expanded(

        child: Container(
        child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 10),
              snapshot.data!.isNotEmpty
              ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<List<Member>>(
                          future: _loadMembersByTeam(snapshot.data![index].getName()),
                          builder: (context, snapshotMembers) {
                            if (snapshotMembers.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshotMembers.hasError) {
                              return Text('Errore: ${snapshotMembers.error}');
                            } else {
                              return ExpandableTeamTile(snapshot.data![index].getName(),snapshotMembers.data!, index);
                            }
                          },
                        );
                      })
                  : const Text("Al momento non è presente alcun team."),
            ])));
        }
  }),
  ]));        
              }


        

  toFilteredList(String text) async {
    filteredList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var item in await DatabaseHelper.instance.getTeams()) {
      if (item.name.toLowerCase().contains(text.toLowerCase())) {
        filteredList.add(item);
      }
    }
    setState(() {});
  }

  Widget buildTeamContainer(List<Team> list) {
  
  return Expanded(

        child: Container(
        child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 10),
              list.isNotEmpty
              ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<List<Member>>(
                          future: _loadMembersByTeam(list[index].getName()),
                          builder: (context, snapshotMembers) {
                            if (snapshotMembers.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshotMembers.hasError) {
                              return Text('Errore: ${snapshotMembers.error}');
                            } else {
                              return ExpandableTeamTile(list[index].getName(),snapshotMembers.data!, index);
                            }
                            
                          },
                        );
                      })
                  : const Text("Nessun Team trovato."),
            ])));
  
}





}

class ExpandableTeamTile extends StatefulWidget {
  ExpandableTeamTile(this.teamName,this.memberList, this.index, {super.key});
  String teamName;
  List<Member> memberList;
  int index;

  @override
  State<ExpandableTeamTile> createState() => _ExpandableTeamTileState();
}

class _ExpandableTeamTileState extends State<ExpandableTeamTile> {
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
                        Column(
              children: [
                Row(
                  children: [
                    //Icon(Icons.person, size: 35,),
                            //SizedBox(width: 10,),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Matricola:'),
                        Text('Nome:'),
                        Text('Cognome:'),
                        Text('Ruolo:')
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              member.getCode().toString()),
                          Text(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              member.getMemberName()),
                          Text(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              member.getMemberSurname()),
                          Text(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              member.getMemberRole())
                        ])
                  ],
                )
              ],
            ),




                      /*Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 30, bottom: 5),
                          child: Text('${member.name} ${member.surname}'))*/
                  ]
                ),
              ],
            )));
  }
  
}








/*
class MemberListView extends StatelessWidget {
  MemberListView(this.memberList, {super.key});
  List<Member> memberList;
class MemberListView extends StatelessWidget {
              children: [
                Row(
                  children: [
                    /*Icon(Icons.person, size: 35,),
                            SizedBox(width: 10,),*/
                    //Icon(Icons.person, size: 35,),
                            //SizedBox(width: 10,),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
class _ExpandableTeamTileState extends State<ExpandableTeamTile> {
    return await DatabaseHelper.instance.getMembersByTeam(teamName);
  }
  
}
} 
*/