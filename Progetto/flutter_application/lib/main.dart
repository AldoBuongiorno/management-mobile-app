import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'home.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //se tolgo non cambia niente

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCMToken $fcmToken');

  await deleteDatabase(join(await getDatabasesPath(), 'my_database.db'));
  final db = DatabaseHelper.instance;
  await db.database;
  DatabaseHelper.instance.database.then((_) {
    //ProjectList().loadSampleData();
    runApp(Group21App());
  });

  //se tolgo non cambia niente
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 20, 0, 0),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class Group21App extends StatefulWidget {

  @override
  _Group21AppState createState() => _Group21AppState();
}

class _Group21AppState extends State<Group21App> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }

  BoxDecoration getGradientDecoration() {
    //gradiente per lo sfondo degli screen dell'app
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
    //tema barra di navigazione sotto
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
        debugShowCheckedModeBanner:
            false, //non mostra il banner di debug in alto a destra
        title: 'Gruppo 21',
        theme: ThemeData(
            textSelectionTheme: const TextSelectionThemeData(
              //tema del cursore del testo e dello sfondo del testo selezionato
              selectionHandleColor: Colors.pink,
              selectionColor: Colors.pinkAccent,
              cursorColor: Colors.pink,
            ),
            scaffoldBackgroundColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
              //tema barra superiore dell'applicazione
              backgroundColor: Color.fromARGB(0, 0, 0, 0),
              toolbarHeight: 50,
            ),
            textTheme: Theme.of(context).textTheme.apply(
                  //tema del testo
                  bodyColor: const Color.fromARGB(255, 0, 0, 0),
                  displayColor: const Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Poppins',
                )),
        home: const HomePage(),
      ),
    );
  }
}
