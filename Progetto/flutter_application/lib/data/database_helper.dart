import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application/classes/sql_classes/sqlite_class_all';


class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE Project(
            name TEXT PRIMARY KEY,
            description TEXT NOT NULL,
            creationDate TEXT NOT NULL,
            expirationDate TEXT NOT NULL,
            lastModified TEXT NOT NULL,
            status TEXT NOT NULL,
            projectFailureReason TEXT,
            team TEXT NOT NULL,
            thumbnail TEXT NOT NULL,
            FOREIGN KEY(team) REFERENCES Team(name)
          )
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE Task(
            name TEXT PRIMARY KEY,
            completed INTEGER NOT NULL,
            project TEXT NOT NULL,
            FOREIGN KEY(project) REFERENCES Project(name)
          )
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE Team(
            name TEXT PRIMARY KEY
          )
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE Member(
            code INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            surname TEXT NOT NULL,
            role TEXT NOT NULL,
            mainTeam TEXT,
            secondaryTeam TEXT,
            FOREIGN KEY(mainTeam) REFERENCES Team(name),
            FOREIGN KEY(secondaryTeam) REFERENCES Team(name)
          )
          ''',
        );
      },
      version: 1,
    );
  }

}
