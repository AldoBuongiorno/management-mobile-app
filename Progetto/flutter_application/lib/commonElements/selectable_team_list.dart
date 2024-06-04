import 'package:flutter/material.dart';
import 'package:flutter_application/data/database_helper.dart';
import '../classes/team_class.dart';

// ignore: must_be_immutable
class SelectableTeamsList extends StatefulWidget {
  SelectableTeamsList({required this.teamsList, this.selectedTeam = 0});
  List<Team> teamsList;
  int selectedTeam;
  @override
  State<SelectableTeamsList> createState() => _SelectableTeamsListState();
}

class _SelectableTeamsListState extends State<SelectableTeamsList> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Team>> _loadTeams() async {
    List<Team> teamsList = await DatabaseHelper.instance.getTeams();
    return teamsList;
  }

  @override
  Widget build(BuildContext context) {
    return widget.teamsList.isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              //direction: Axis.horizontal,
              //verticalDirection: VerticalDirection.down,
              //spacing: 5.0,
              children: List<Row>.generate(
                widget.teamsList.length,
                (int index) {
                  return Row(children: [ ChoiceChip(
                    selectedColor: Colors.pink,
                    checkmarkColor:  Colors.white,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(width: 0, color: widget.selectedTeam == index ? Colors.pink : Colors.white)),
     
                    labelStyle: TextStyle(color: widget.selectedTeam == index ? Colors.white : Colors.black),
                    //iconTheme: IconThemeData(color: widget.selectedTeam == index ? Colors.white : Colors.black),
                    label: Text(widget.teamsList[index].getName()),
                    selected: widget.selectedTeam == index,
                    onSelected: (bool selected) {
                      setState(() {
                        widget.selectedTeam = selected ? index : 0;
                      });
                    },
                  ), const SizedBox(width: 5)] );
                },
              ).toList(),
            ))
        : const Text(
            "Non ci sono team disponibili. Non è possibile creare un progetto senza team.");
  }
}
