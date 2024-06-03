import 'package:flutter/material.dart';
import 'package:flutter_application/data/database_helper.dart';
import '../classes/team_class.dart';

// ignore: must_be_immutable
class SelectableTeamsList extends StatefulWidget {
  SelectableTeamsList({super.key});
  int selectedTeam = 0;
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
    return FutureBuilder(
        future: _loadTeams(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return snapshot.data!.isNotEmpty
                ? Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(
                      snapshot.data!.length,
                      (int index) {
                        return ChoiceChip(
                          selectedColor: Colors.pink,
                          iconTheme: const IconThemeData(color: Colors.white),
                          label: Text(snapshot.data![index].getName()),
                          selected: widget.selectedTeam == index,
                          onSelected: (bool selected) {
                            setState(() {
                              widget.selectedTeam = selected ? index : 0;
                            });
                          },
                        );
                      },
                    ).toList(),
                  )
                : const Text(
                    "Non ci sono team disponibili. Non è possibile creare un progetto senza team.");
          }
        });
  }
}
