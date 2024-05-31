import 'package:flutter/material.dart';
import 'package:flutter_application/navigation/routes/edit_project_screen.dart';
import '../commonElements/blurred_box.dart';
import '../data/project_list.dart';
import '../commonElements/carousel_item.dart';
import 'routes/project_screen.dart';
import 'package:flutter_application/classes/all.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});
  @override
  @override
  State<ProjectScreen> createState() => _ProjectScreen();
}

class _ProjectScreen extends State<ProjectScreen> {
  List<Project> filteredList = [];
  List<Widget> projectContainers = [];
  final filterProjectListController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 20
                    : 100),
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
                    hintText: 'Cerca progetti...',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
                onChanged: toFilteredList,
              )),
          const SizedBox(
            height: 20,
          ),
          filteredList.isNotEmpty || filterProjectListController.text.isNotEmpty
              ? buildProjectContainer(filteredList, context)
              : buildProjectContainer(ProjectList.projectsList, context),
        ]));
  }

  //ListView.builder(itemBuilder: itemBuilder),)

  toFilteredList(String text) {
    filteredList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var item in ProjectList.projectsList) {
      if (item.name.toLowerCase().contains(text.toLowerCase())) {
        filteredList.add(item);
      }
    }
    setState(() {});
  }
}

Widget buildProjectContainer(list, context) {
  return Expanded(
    child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
        itemCount: list.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProjectRoute(
                          ProjectList.projectsList.indexOf(list[index])))),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: list[index].thumbnail, fit: BoxFit.cover),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //const SizedBox(width: 15),
                        statusCheck(list[index]),
                        IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProjectScreen(
                                          index: ProjectList.projectsList
                                              .indexOf(list[index]),
                                        ))),
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    //SizedBox(height: 3),
                    Column(children: [
                      Row(
                        children: [
                          const SizedBox(width: 12),
                          Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: teamCheck(list[index])))
                        ],
                      ),
                      BlurredBox(
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20)),
                          sigma: 15,

                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(100, 0, 0, 0)),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                getProjectName(list[index]),
                              ],
                            ),
                          ))
                    ]),
                  ],
                ),
              ));
        })),
  );
}

