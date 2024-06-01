import 'package:flutter/material.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'package:flutter_application/navigation/routes/edit_team_route.dart';
import '../commonElements/blurred_box.dart';
import '../commonElements/responsive_padding.dart';
import 'package:flutter_application/classes/all.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  List<Team> teamList = [];
  List<Team> filteredList = [];

  Future<void> _loadTeams() async {
    final teams = await DatabaseHelper.instance.getTeams();
    setState(() {
      teamList = teams;
      filteredList = teams;
    });
  }

  final filterTeamListController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTeams();
  }

  void _filterTeams(String query) {
    final filtered = teamList.where((team) {
      final teamNameLower = team.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return teamNameLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredList = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getResponsivePadding(context),
      child: Column(
        children: [
          BlurredBox(
            borderRadius: BorderRadius.circular(30),
            sigma: 5,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: filterTeamListController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                filled: true,
                fillColor: Color.fromARGB(100, 0, 0, 0),
                suffixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: 'Cerca team...',
                hintStyle: TextStyle(color: Color.fromARGB(255, 192, 192, 192)),
              ),
              onChanged: _filterTeams,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredList.isNotEmpty
                ? GridView.builder(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          height: 200,
                          padding: EdgeInsets.zero,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [/*
                                  IconButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditTeamScreen(
                                          team: filteredList[index],
                                        ),
                                      ),
                                    ).then((_) => _loadTeams()),
                                    icon: const Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                    ),
                                  ),*/
                                ],
                              ),
                              
                            ],
                          )
                        );
                    },
                  )
                : const Center(child: Text("Nessun team trovato.")),
          ),
        ],
      ),
    );
  }
}









