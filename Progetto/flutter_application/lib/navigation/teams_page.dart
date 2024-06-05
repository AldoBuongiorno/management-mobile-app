import 'package:flutter/material.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'package:flutter_application/navigation/routes/edit_team_route.dart';
import 'package:flutter_application/navigation/routes/view_team_route.dart';
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
    filterTeamListController.addListener(() {
      _filterTeams(filterTeamListController.text);
    });
  }

  @override
  void dispose() {
    filterTeamListController.dispose();
    super.dispose();
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                filled: true,
                fillColor: Color.fromARGB(100, 0, 0, 0),
                suffixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: 'Cerca team...',
                hintStyle: TextStyle(color: Color.fromARGB(255, 192, 192, 192)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredList.isNotEmpty
                ? GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics()
                        .applyTo(const BouncingScrollPhysics()),
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 2
                          : 3, // Aumenta il numero di colonne per rendere i riquadri più piccoli
                      crossAxisSpacing: 10, // Aumenta lo spazio tra le colonne
                      mainAxisSpacing: 0, // Aumenta lo spazio tra le righe
                      childAspectRatio: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 1.2
                          : 2, // Riduce l'altezza dei riquadri
                    ),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TeamRoute(team: filteredList[index])),
                              ).then((_) => _loadTeams()),
                          child: Container(
                            height:
                                150, // Regola l'altezza del contenitore se necessario
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: filteredList[index].thumbnail,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                            padding: EdgeInsets.zero,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditTeamScreen(
                                              team: filteredList[index]),
                                        ),
                                      ).then((_) => _loadTeams()),
                                      icon: const Icon(Icons.draw,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    BlurredBox(
                                      borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(15),
                                      ),
                                      sigma: 15,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3),
                                        decoration: const BoxDecoration(
                                            color:
                                                Color.fromARGB(100, 0, 0, 0)),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            Flexible(
                                              child: Text(
                                                filteredList[index].getName(),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize:
                                                      16, // Diminuisci la dimensione del testo
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                    },
                  )
                : const Center(child: Text("Nessun team trovato.")),
          ),
        ],
      ),
    );
  }
}
