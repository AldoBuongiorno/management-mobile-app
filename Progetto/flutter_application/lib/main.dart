import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/database_helper.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //await FirebaseMessaging.instance.setAutoInitEnabled(true);
  //final fcmToken = await FirebaseMessaging.instance.getToken();
  //print('FCMToken $fcmToken');

  //await deleteDatabase(join(await getDatabasesPath(), 'my_database.db'));
  final db = DatabaseHelper.instance;
  await db.database;
  DatabaseHelper.instance.database.then((_) {
    runApp(const Group21App());
  });


  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 20, 0, 0),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class Group21App extends StatefulWidget {
  const Group21App({super.key});

  @override
  State<Group21App> createState() => _Group21AppState();
}

class _Group21AppState extends State<Group21App> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission();
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
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getGradientDecoration(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //non mostra il banner di debug in alto a destra
        title: 'Gruppo 21',
        theme: ThemeData(
          //datePickerTheme: DatePickerThemeData().copyWith(),
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
          )
        ),
        home: const HomePage(),
      ),
    );
  }
}
