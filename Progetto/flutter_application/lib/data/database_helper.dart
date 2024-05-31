import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application/classes/all.dart';


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
            creationDate TEXT,
            expirationDate TEXT,
            lastModified TEXT,
            status TEXT,
            projectFailureReason TEXT,
            team TEXT,
            thumbnail TEXT NOT NULL,
            FOREIGN KEY(team) REFERENCES Team(name)
          )
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE Task(
            name TEXT PRIMARY KEY,
            completationDate TEXT,
            completed INTEGER NOT NULL,
            progress REAL NOT NULL,
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

  Future<void> insertProject(Project project) async {
    final db = await database;
    await db.insert(
      'Project', 
      project.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('Task', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTeam(Team team) async {
    final db = await database;
    await db.insert('Team',team.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertMember(Member member) async {
    final db = await database;
    await db.insert('Member', member.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> addTeamToMember(int code, String team) async {
  final db = await database;
  await db.update('Member', {'mainTeam': team}, where: 'code = ?', whereArgs: [code]);
  }

  Future<List<Project>> getProjects() async {
    final db = await database;
    final List<Map<String, Object?>> projectsMaps = await db.query('Project');
    return [
      for (final {'name': name as String,'description': description as String,'creationDate': creationDate as String,'expirationDate': expirationDate as String,'lastModified': lastModified as String,'status': status as String,'projectFailureReason': projectFailureReason as String?,'team': team as String,'thumbnail': thumbnail as String,} in projectsMaps)
        Project(name: name, description: description, creationDate: DateTime.parse(creationDate), expirationDate: DateTime.parse(expirationDate), lastModified: DateTime.parse(lastModified), status: status, projectFailureReason: projectFailureReason,team: await getTeamByName(team), thumbnail: AssetImage(thumbnail)),
    ];
  }

   Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, Object?>> tasksMaps = await db.query('Task');
    return [
      for (final {'name': name as String,'completationDate': completationDate as String,'completed': completed as int,'progress': progress as double,'project': project as String,} in tasksMaps)
        Task(name: name,completationDate: DateTime.parse(completationDate),completed: (completed == 1 ? true : false),progress: progress,project: await getProjectByName(project)),
    ];
  }

  Future<List<Team>> getTeams() async { 
    final db = await database; 
    final List<Map<String, Object?>> teamsMaps = await db.query('Team'); 
    return [ 
      for(final {'name': name as String, } in teamsMaps) 
      Team(name: name),
    ];
  }

  Future<List<Member>> getMembers() async {
    final db = await database;
    final List<Map<String, Object?>> membersMaps = await db.query('Member');
    return [
      for (final {'code': code as int,'name': name as String,'surname': surname as String,'role': role as String,'mainTeam': mainTeam as String?,'secondaryTeam': secondaryTeam as String?,} in membersMaps)
        Member(code: code, name: name, surname: surname, role: role,mainTeam: await getTeamByName(mainTeam), secondaryTeam: await getTeamByName(secondaryTeam) ),
    ];
  }

  Future<Project?> getProjectByName(String name) async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.query('Project',where: 'name = ?',whereArgs: [name],);
    if (result.isEmpty) {
      return null; }
    final projectMap = result.first;
    return Project(name: projectMap['name'] as String, description: projectMap['description'] as String, creationDate: DateTime.parse(projectMap['creationDate'] as String), expirationDate: DateTime.parse(projectMap['expirationDate'] as String), lastModified: DateTime.parse(projectMap['lastModified'] as String), status: projectMap['status'] as String, projectFailureReason: projectMap['projectFailureReason'] as String,team: await getTeamByName(projectMap['team'] as String), thumbnail: AssetImage(projectMap['thumbnail'] as String),
    );
  }

  Future<Task?> getTaskByName(String name) async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.query('Task',where: 'name = ?',whereArgs: [name],);
    if (result.isEmpty) {
      return null; }
    final taskMap = result.first;
    return Task(name: taskMap['name'] as String,completationDate: DateTime.parse(taskMap['completationDate'] as String),completed: (taskMap['completed'] as int) == 1 ? true : false,progress: taskMap['progress'] as double,project: await getProjectByName(taskMap['project'] as String),
    );
  }

  Future<Team?> getTeamByName(String? name) async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.query('Team',where: 'name = ?',whereArgs: [name],);
    if (result.isEmpty) {
      return null; }
    final teamMap = result.first;
    return Team(name: teamMap['name'] as String,
    );
  }

  Future<Member?> getMemberByCode(int code) async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.query('Member',where: 'code = ?',whereArgs: [code],);
    if (result.isEmpty) {
      return null; }
    final memberMap = result.first;
    return Member(code: memberMap['code'] as int,name: memberMap['name'] as String,surname: memberMap['surname'] as String,role: memberMap['role'] as String,mainTeam: await getTeamByName(memberMap['mainTeam'] as String),secondaryTeam: await getTeamByName(memberMap['secondaryTeam'] as String),
    );
  }

  Future<void> updateTeamName(String oldName, String newName) async {
    final db = await database;
    await db.update('Project',{'team': newName,'lastModified': DateTime.now().toIso8601String()},where: 'team = ?',whereArgs: [oldName],);
  }

  Future<void> updateDescription(String project, String newDescription) async {
    final db = await database;
    await db.update('Project',{'description': newDescription,'lastModified': DateTime.now().toIso8601String()},where: 'name = ?',whereArgs: [project],);
  }

  Future<void> updateExpirationDate(String project, DateTime newDate) async {
    final db = await database;
    await db.update('Project',{'expirationDate': newDate.toIso8601String(),'lastModified': DateTime.now().toIso8601String()},where: 'name = ?',whereArgs: [project],);
  }

  Future<void> updateStatus(String project, String newStatus) async {
    final db = await database;
    await db.update('Project',{'status': newStatus,'lastModified': DateTime.now().toIso8601String()},where: 'name = ?',whereArgs: [project],);
  }

  Future<void> updateTeam(String project, String newTeamName) async {
    final db = await database;
    await db.update('Project',{'team': newTeamName,'lastModified': DateTime.now().toIso8601String()},where: 'name = ?',whereArgs: [project],);
  }

  Future<void> updateThumbnail(String project, String newThumbnail) async {
    final db = await database;
    await db.update('Project',{'thumbnail': newThumbnail,'lastModified': DateTime.now().toIso8601String()},where: 'name = ?',whereArgs: [project],);
  }
  
  Future<void> updateTaskName(String oldName, String newName) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('SELECT t.project AS project_name FROM Task t WHERE t.name = ?',[oldName],);
    await db.rawUpdate('UPDATE Project SET lastModified = ? WHERE name = ?',[DateTime.now().toIso8601String(), result.first['name'] as String],);
    await db.update('Task',{'name': newName},where: 'name = ?',whereArgs: [oldName],);
   }

  Future<void> updateCompletationDate(String task, DateTime newDate) async {
    final db = await database;
    await db.update('Task',{'completationDate': newDate.toIso8601String()},where: 'name = ?',whereArgs: [task],);
    final List<Map<String, dynamic>> result = await db.rawQuery('SELECT t.project AS project_name FROM Task t WHERE t.name = ?',[task],);
    await db.rawUpdate('UPDATE Project SET lastModified = ? WHERE name = ?',[DateTime.now().toIso8601String(), result.first['name'] as String],);
  }

  Future<void> updateCompleted(String task, bool isCompleted) async {
    final db = await database;
    await db.update('Task',{'completed': isCompleted ? 1 : 0},where: 'name = ?',whereArgs: [task],);
    final List<Map<String, dynamic>> result = await db.rawQuery('SELECT t.project AS project_name FROM Task t WHERE t.name = ?',[task],);
    await db.rawUpdate('UPDATE Project SET lastModified = ? WHERE name = ?',[DateTime.now().toIso8601String(), result.first['name'] as String],);
  }

  Future<void> updateProgress(String task, double newProgress) async {
    final db = await database;
    await db.update('Task',{'progress': newProgress},where: 'name = ?',whereArgs: [task],);
    final List<Map<String, dynamic>> result = await db.rawQuery('SELECT t.project AS project_name FROM Task t WHERE t.name = ?',[task],);
    await db.rawUpdate('UPDATE Project SET lastModified = ? WHERE name = ?',[DateTime.now().toIso8601String(), result.first['name'] as String],);
  } 

  Future<void> deleteProject(String name) async {
    final db = await database;
    await db.delete('Project',where: 'name = ?',whereArgs: [name],);
  }

  Future<void> deleteTask(String name) async {
    final db = await database;
    await db.delete('Task',where: 'name = ?',whereArgs: [name],);
  }

  Future<void> deleteTeam(String name) async {
    final db = await database;
    await db.delete('Team',where: 'name = ?',whereArgs: [name],);
  }

  Future<void> deleteMember(int code) async {
    final db = await database;
    await db.delete('Member',where: 'code = ?',whereArgs: [code],);
  }

  Future<List<Project>> getActiveProjectsOrderedByLastModified() async {
    final db = await database;
    final List<Map<String, Object?>> projectsMaps = await db.query('Project',where: 'status = ?',whereArgs: ['Attivo'],orderBy: 'lastModified DESC',);
    return [
      for (final {'name': name as String,'description': description as String,'creationDate': creationDate as String,'expirationDate': expirationDate as String,'lastModified': lastModified as String,'status': status as String,'projectFailureReason': projectFailureReason as String?,'team': team as String,'thumbnail': thumbnail as String,} in projectsMaps)
        Project(name: name, description: description, creationDate: DateTime.parse(creationDate), expirationDate: DateTime.parse(expirationDate), lastModified: DateTime.parse(lastModified), status: status, projectFailureReason: projectFailureReason, team: await getTeamByName(team), thumbnail: AssetImage(thumbnail)),
    ];
  }

  Future<List<Task>> getTasksByProjectName(String project) async {
    final db = await database;
    final List<Map<String, Object?>> tasksMaps = await db.query('Task',where: 'project = ?',whereArgs: [project],);
    return [
      for (final {'name': name as String,'completationDate': completationDate as String?,'completed': completed as int,'progress': progress as double,'project': project as String,} in tasksMaps)
        Task(name: name,completationDate: completationDate != null ? DateTime.parse(completationDate) : null,completed: completed == 1,progress: progress,project: await getProjectByName(project),),
    ];
  }

  Future<List<Team>> getTeamsOrderedByMemberCount() async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT Team.name, COUNT(Member.code) as memberCount
      FROM Team
      JOIN Member ON Team.name = Member.mainTeam OR Team.name = Member.secondaryTeam
      GROUP BY Team.name
      ORDER BY memberCount DESC
    ''');
    return [for (final row in result) Team(name: row['name'] as String),];
  }

  Future<List<Member>> getMembersByTeam(String team) async {
    final db = await database;
    final List<Map<String, Object?>> membersMaps = await db.query('Member',where: 'mainTeam = ? OR secondaryTeam = ?',whereArgs: [team, team],);
    return [
      for (final memberMap in membersMaps)
        Member(code: memberMap['code'] as int,name: memberMap['name'] as String,surname: memberMap['surname'] as String,role: memberMap['role'] as String,mainTeam: await getTeamByName(memberMap['mainTeam'] as String?),secondaryTeam: await getTeamByName(memberMap['secondaryTeam'] as String?),),
    ];
  }


}
