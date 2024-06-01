import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'package:flutter_application/data/project_list.dart';
import 'home.dart';
import '../commonElements/responsive_padding.dart';


void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  final db = DatabaseHelper.instance; 
  await db.database; 
  DatabaseHelper.instance.database.then((_) {
    ProjectList().loadSampleData();
    runApp(const Group21App());   
  });
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); 
}



class Group21App extends StatelessWidget {
  const Group21App({super.key});

  static const NavigationBarThemeData navigationBarTheme = NavigationBarThemeData(
    height: 55,
    indicatorColor: Color.fromARGB(255, 235, 235, 235),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    backgroundColor: Color.fromARGB(56, 0, 0, 0),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getGradientDecoration(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Gruppo 21',
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(selectionHandleColor: Colors.pink, selectionColor: Colors.pinkAccent, cursorColor: Colors.pink),
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(backgroundColor: Color.fromARGB(0, 0, 0, 0), toolbarHeight: 50),
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: const Color.fromARGB(255, 0, 0, 0),
              displayColor: const Color.fromARGB(255, 0, 0, 0),
              fontFamily: 'Poppins'
          )
        ),
        home: const HomePage(),
      ),
    );
  }
}

