import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'package:flutter_application/data/project_list.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:css_colors/css_colors.dart';
import 'home.dart';
import '../commonElements/responsive_padding.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //se tolgo non cambia niente

  //await deleteDatabase(join(await getDatabasesPath(), 'my_database.db'));
  final db = DatabaseHelper.instance;
  await db.database;
  DatabaseHelper.instance.database.then((_) {
    ProjectList().loadSampleData();
    runApp(const Group21App());
  });

  //se tolgo non cambia niente
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class Group21App extends StatelessWidget {
  const Group21App({super.key});

  BoxDecoration getGradientDecoration() {
    return const BoxDecoration(
        gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 232, 232, 232),
        Color.fromARGB(255, 0, 183, 255),
        Color.fromARGB(255, 0, 183, 255),
        Color.fromARGB(255, 255, 0, 115),
        Color.fromARGB(255, 255, 0, 115),
        Colors.yellow,
      ],
      stops: [0.79, 0.79, 0.865, 0.865, 0.94, 0.94],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ));
  }

  static const NavigationBarThemeData navigationBarTheme =
      NavigationBarThemeData(
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
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.pink,
            selectionColor: Colors.pinkAccent,
            cursorColor: Colors.pink,
          ),
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
            toolbarHeight: 50,
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: const Color.fromARGB(255, 0, 0, 0),
                displayColor: const Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Poppins',
              ),
          navigationBarTheme: navigationBarTheme,
        ),
        home: const HomePage(),
      ),
    );
  }
}
