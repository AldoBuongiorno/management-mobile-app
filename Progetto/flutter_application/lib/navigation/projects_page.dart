import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/responsive_padding.dart';
import 'package:flutter_application/navigation/routes/edit_project_route.dart';
import '../commonElements/blurred_box.dart';
import '../data/database_helper.dart';
import '../commonElements/carousel_item.dart';
import 'routes/view_project_route.dart';
import 'package:flutter_application/classes/all.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});
  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  List<Project> projectList = [];
  List<Project> filteredList = [];

  final filterProjectListController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProjects();
    filterProjectListController.addListener(() {
      _filterProjects(filterProjectListController.text);
    });
  }

   @override
  void dispose() {
    filterProjectListController.dispose();
    super.dispose();
  }

  Future<void> _loadProjects() async {
    final projects = await DatabaseHelper.instance.getProjects();
    setState(() {
      projectList = projects;
      filteredList = projects;
    });
  }

  void _filterProjects(String query) {
    final filtered = projectList.where((project) {
      final projectNameLower = project.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return projectNameLower.contains(queryLower);
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
              controller: filterProjectListController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                filled: true,
                fillColor: Color.fromARGB(100, 0, 0, 0),
                suffixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: 'Cerca progetti...',
                hintStyle: TextStyle(color: Color.fromARGB(255, 192, 192, 192)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredList.isNotEmpty ? ListView.builder(
              physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProjectRoute(filteredList[index])),
                  ).then((_) => _loadProjects()),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: filteredList[index].thumbnail,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: EdgeInsets.zero,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            statusCheck(filteredList[index]),
                            IconButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditProjectScreen(
                                  project: filteredList[index],
                                )),
                              ).then((_) => _loadProjects()),
                              icon: const Icon(
                                Icons.draw,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 12),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: teamCheck(filteredList[index]),
                                  ),
                                ),
                              ],
                            ),
                            BlurredBox(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(20),
                              ),
                              sigma: 15,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(100, 0, 0, 0),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 15),
                                    getProjectName(filteredList[index]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ) : const Center(child: Text("Nessun progetto trovato")),
          ),
        ],
      ),
    );
  }
}


