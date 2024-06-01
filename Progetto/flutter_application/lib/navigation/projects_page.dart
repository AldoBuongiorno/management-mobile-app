

import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/responsive_padding.dart';
import 'package:flutter_application/navigation/routes/edit_project_route.dart';
import '../commonElements/blurred_box.dart';
import '../data/database_helper.dart';
import '../data/project_list.dart';
import '../commonElements/carousel_item.dart';
import 'routes/project_view_route.dart';
import 'package:flutter_application/classes/all.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});
  @override
  @override
  State<ProjectScreen> createState() => _ProjectScreen();
}

class _ProjectScreen extends State<ProjectScreen> {
  List<Project> filteredList = [];

  Future<List<Project>> _loadProjects() async {
    return await DatabaseHelper.instance.getProjects(); 
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
                    hintText: 'Cerca progetti...',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
                onChanged: toFilteredList,
              )),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(future: _loadProjects(), builder: (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return 
          filteredList.isNotEmpty || filterProjectListController.text.isNotEmpty
              ? buildProjectContainer(filteredList)
              : //buildProjectContainer(snapshot.data!); 
                Expanded(
    child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
        itemCount: snapshot.data!.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProjectRoute(
                          snapshot.data![index]))).then((_) => setState(() {})),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: snapshot.data![index].thumbnail, fit: BoxFit.cover),
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
                        statusCheck(snapshot.data![index]),
                        IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProjectScreen(
                                          project: snapshot.data![index],
                                        ))).then((_) => setState(() {})),
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
                                  child: teamCheck(snapshot.data![index])))
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
                                getProjectName(snapshot.data![index]),
                              ],
                            ),
                          ))
                    ]),
                  ],
                ),
              ));
        })),
  );
              
              
              }})
        ]));
  

        }

    
    


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


/*class ProjectContainer extends StatefulWidget {
  ProjectContainer({super.key, required this.projectsList});
  List<Project> projectsList;

  State<ProjectContainer>
}*/



Widget buildProjectContainer(List<Project> list) {



  
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
                          list[index]))),
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
                                          project: list[index],
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

