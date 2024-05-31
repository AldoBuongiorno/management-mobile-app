import 'package:flutter/material.dart';

import '../data/project_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return ProjectList.teamsList.isNotEmpty ?
    Wrap(
              
              spacing: 5.0,
              children: List<Widget>.generate(
                ProjectList.teamsList.length,
                (int index) {
                  return ChoiceChip(
                    
                    selectedColor: Colors.pink,
                    iconTheme: const IconThemeData(color: Colors.white),
                    label: Text(ProjectList.teamsList[index].getName()),
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
    : const Text("Non ci sono team disponibili. Non è possibile creare un progetto senza team.");
  }
  
}