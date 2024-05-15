import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
void main() => runApp(Group21App());

class Group21App extends StatelessWidget {
  const Group21App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gruppo 21',
      theme: ThemeData(fontFamily: 'Poppins', scaffoldBackgroundColor: Colors.amber, appBarTheme: AppBarTheme(backgroundColor: Colors.amber)),
      
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [
    HomePageScreen(),
    Center(child: Text('Progetti')),
    Center(child: Text('Gestione')),
    Center(child: Text('Statistiche')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Color.fromARGB(255, 0, 0, 0)),
        ),
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
            height: 55,
            indicatorColor: Color.fromARGB(255, 38, 255, 0),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            backgroundColor: Colors.black,
          ),
          child: NavigationBar(
            //animationDuration: Duration(seconds: 1),
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: ''),
              NavigationDestination(
                  icon: Icon(Icons.map_outlined),
                  selectedIcon: Icon(Icons.map),
                  label: ''),
              NavigationDestination(
                  icon: Icon(Icons.person_outlined),
                  selectedIcon: Icon(Icons.person),
                  label: ''),
              NavigationDestination(
                  icon: Icon(Icons.add_chart_outlined),
                  selectedIcon: Icon(Icons.add_chart),
                  label: ''),
            ],
          ),
        ));
  }
}

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.amber,
        body: Container(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(alignment: Alignment(-0.5, 0), child: Text("Progetti recenti", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))),
          SizedBox(height: 10),
          CarouselSlider.builder(
              itemCount: imgList.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = imgList[index];
                return buildImage(urlImage, index);
              },
              options: CarouselOptions(height: 200))
        ],
      ),
    ));
  }
}

Widget buildImage(String urlImage, int index) => Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(urlImage), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(horizontal: 5),
      //child: Image.network(urlImage, height: 300)
    );
