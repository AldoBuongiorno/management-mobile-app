import 'package:flutter/material.dart';
import '../commonElements/blurredBox.dart';
import '../commonElements/headings_title.dart';
import '../projectItems.dart';
import '../projectList/projectList.dart';

//List<Member> memberList = getMembersList(); //.add(Member("Mario", "Rossi", "Impiegato"));

class MemberListView extends StatelessWidget {
  MemberListView(this.memberList);
  List<Member> memberList;
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: memberList.length,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Nome:'),
                                Text('Cognome:'),
                                Text('Ruolo:')
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      memberList[index].name),
                                  Text(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      memberList[index].surname),
                                  Text(
                                      style: TextStyle(
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
  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  List<Member> memberList = List.from(<Member>[
    Member("Mario", "Rossi", "Impiegato"),
    Member("Jeanne", "QT", "Altro")
  ]);

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
              SizedBox(height: 10),
              Text(
                  "Per aggiungere partecipanti, recati nella schermata di aggiunta progetti e team."),
              SizedBox(
                height: 5,
              ),
              !memberList.isEmpty
                  ? MemberListView(memberList)
                  : Text("Al momento non sono presenti partecipanti."),
              SizedBox(height: 10),
              CustomHeadingTitle(titleText: "Team"),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ProjectList().getTeam().length,
                  itemBuilder: (context, index) {
                    return ExpansionTileExample(memberList, index);
                  })
            ])));
  }
}

class ExpansionTileExample extends StatefulWidget {
  ExpansionTileExample(this.memberList, this.index, {super.key});
  List<Member> memberList;
  int index;

  @override
  State<ExpansionTileExample> createState() => _ExpansionTileExampleState();
}

class _ExpansionTileExampleState extends State<ExpansionTileExample> {
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
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: <Widget>[
                ExpansionTile(
                  iconColor: Colors.lightBlue,
                  collapsedIconColor: Colors.pink,
                  expandedAlignment: Alignment.centerLeft,

                  title: Text(
                    teamList[widget.index].teamName,
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  ),
                  //subtitle: Text('Trailing expansion arrow icon'),
                  children: [
                    for (Member member in widget.memberList)
                      Container(
                          margin: EdgeInsets.only(left: 30, bottom: 5),
                          child: Text(member.name + ' ' + member.surname))
                  ],
                ),
              ],
            )));
  }
}
