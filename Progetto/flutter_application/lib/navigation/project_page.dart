import 'package:flutter/material.dart';
import '../commonElements/blurredBox.dart';
import '../projectItems.dart';
import '../projectList/projectList.dart';
import '../carouselItem.dart';
import './screens/project_screen.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});
  @override


  @override
  _ProjectScreen createState() => _ProjectScreen();
}

class _ProjectScreen extends State<ProjectScreen> {
  List<ProjectItem> list = ProjectList().getList();
  List<ProjectItem> filteredList = List.empty(growable: true);
  List<Widget> projectContainers = List.empty(growable: true);
  final filterProjectListController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Container(margin: EdgeInsets.symmetric(vertical: 10,
                        horizontal: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 20
                            : 100),
       child: Column(
        
          
      children: [ 
        
        BlurredBox(
            borderRadius: 30,
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
                  hintStyle: TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
                  onChanged: toFilteredList,
            )),
        SizedBox(height: 20,),
        filteredList.length != 0 || filterProjectListController.text.isNotEmpty ? buildProjectContainer(filteredList, context) : buildProjectContainer(list, context)

         ] ));   }

    //ListView.builder(itemBuilder: itemBuilder),)
  
  toFilteredList(String text) {
    filteredList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }


    for (var item in list) {
      if (item.name.toLowerCase().contains(text.toLowerCase())) {
        filteredList.add(item);
      }
    }
    setState(() {for(var item in filteredList) { print(item.name);} });
  }
}


Widget buildProjectContainer(list, context) {
  return Expanded( child: Container(child: ListView.builder(
            //physics: AlwaysScrollableScrollPhysics(),
            //shrinkWrap: false,
            itemCount: list.length,
            itemBuilder: ((context, index) {
              
              
              
              
              
              return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProjectRoute(index))),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: list[index].preview,
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //SizedBox(height: 0),
                        //Align(alignment: Alignment(-0.5, 0), child: Text("Progetti recenti", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white))),
                        Row(
                          children: [
                            SizedBox(width: 15),
                            statusCheck(list[index]),
                          ],
                        ),
                        //SizedBox(height: 3),
                        Column(children: [
                          Row(
                            children: [
                              SizedBox(width: 12),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: teamCheck(list[index])))
                            ],
                          ),
                          Container(
                            height: 45,
                            alignment: Alignment.bottomLeft,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    //Color.fromARGB(151, 0, 0, 0),
                                    Color.fromARGB(173, 0, 0, 0),
                                    Color.fromARGB(203, 0, 0, 0)
                                  ],
                                  stops: [0.1, 0.5, 0.9],
                                ),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                  height: 45,
                                ),
                                getProjectName(list[index]),
                              ],
                            ),
                          )
                        ]), //SizedBox(height: 10)
                      ],
                    ),
                    //child: Image.network(urlImage, height: 300)
                  ));

            } ))));
}

/*Widget buildProjectContainer(context, List list, int index) {
  return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProjectRoute(index))),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: list[index].preview, fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.zero,
        margin: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 75
                    : 175),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //SizedBox(height: 0),
            //Align(alignment: Alignment(-0.5, 0), child: Text("Progetti recenti", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white))),
            Row(
              children: [
                SizedBox(width: 15),
                statusCheck(list[index]),
              ],
            ),
            //SizedBox(height: 3),
            Column(children: [
              Row(
                children: [
                  SizedBox(width: 12),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: teamCheck(list[index])))
                ],
              ),
              Container(
                height: 45,
                alignment: Alignment.bottomLeft,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        //Color.fromARGB(151, 0, 0, 0),
                        Color.fromARGB(173, 0, 0, 0),
                        Color.fromARGB(203, 0, 0, 0)
                      ],
                      stops: [0.1, 0.5, 0.9],
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                      height: 45,
                    ),
                    getProjectName(list[index]),
                  ],
                ),
              )
            ]), //SizedBox(height: 10)
          ],
        ),
        //child: Image.network(urlImage, height: 300)
      ));
}*/
