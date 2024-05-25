import 'package:flutter/material.dart';
import '../commonElements/blurred_box.dart';
import '../commonElements/headings_title.dart';
import '../commonElements/project_items.dart';
import '../data/project_list.dart';

//List<Member> memberList = getMembersList(); //.add(Member("Mario", "Rossi", "Impiegato"));

class MemberListView extends StatelessWidget {
  MemberListView(this.memberList, {super.key});
  List<Member> memberList;
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: memberList.length,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            /*Icon(Icons.person, size: 35,),
                            SizedBox(width: 10,),*/
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      memberList[index].name),
                                  Text(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      memberList[index].surname),
                                  Text(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      memberList[index].role)
                                ])
                          ],
                        )
                      ],
                    ),
                  );
                }));

  }
}

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 20
                        : 100),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomHeadingTitle(titleText: "Partecipanti"),
              const SizedBox(height: 10),
              const Text(
                  "Per aggiungere partecipanti, recati nella schermata di aggiunta progetti e team."),
              const SizedBox(
                height: 5,
              ),
              ProjectList.membersList.isNotEmpty
                  ? MemberListView(ProjectList.membersList)
                  : const Text("Al momento non sono presenti partecipanti."),
              const SizedBox(height: 10),
              CustomHeadingTitle(titleText: "Team"),
              const SizedBox(height: 10),
              ProjectList.teamsList.isNotEmpty
                  ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ProjectList.teamsList.length,
                  itemBuilder: (context, index) {
                    return ExpandableTeamTile(ProjectList.teamsList[index].members, index);
                  })
                  : const Text("Al momento non è presente alcun team."),
            ])));
  }
}

class ExpandableTeamTile extends StatefulWidget {
  ExpandableTeamTile(this.memberList, this.index, {super.key});
  List<Member> memberList;
  int index;

  @override
  State<ExpandableTeamTile> createState() => _ExpandableTeamTileState();
}

class _ExpandableTeamTileState extends State<ExpandableTeamTile> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<Team> teamList = ProjectList().getTeam();
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

                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: [ Text(
                    teamList[widget.index].teamName,
                    style: const TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                        
                  ),
                  Text(
                    ("(${teamList[widget.index].members.length} membri)"),
                    style: const TextStyle(
                        fontFamily: 'Poppins', fontSize: 14)
                )]),
                  //subtitle: Text('Trailing expansion arrow icon'),
                  children: [
                    for (Member member in teamList[widget.index].members)
                      Container(
                        alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 30, bottom: 5),
                          child: Text('${member.name} ${member.surname}'))
                  ],
                ),
              ],
            )));
  }
}
