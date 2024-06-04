import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application/classes/all.dart';

import '../classes/setting_class.dart';

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
            name TEXT,
            completationDate TEXT,
            completed INTEGER NOT NULL,
            progress REAL NOT NULL,
            project TEXT,
            PRIMARY KEY(name, project),
            FOREIGN KEY(project) REFERENCES Project(name)
          )
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE Team(
            name TEXT PRIMARY KEY,
            thumbnail TEXT NOT NULL
          )
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE Setting(
            name TEXT PRIMARY KEY,
            number INTEGER NOT NULL
          )
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE Member(
            code INTEGER PRIMARY KEY AUTOINCREMENT,
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
        await db.rawInsert(
          '''
          INSERT INTO Setting values('NumberOfProjectsOnHomepage', 5), ('NumberOfTeamsOnHomepage', 3);
          ''',
        );
        await db.rawInsert('''
          INSERT INTO Team (name, thumbnail) VALUES 
            ('Development', 'assets/images/teamPreview/teamsei.jpg'),
            ('Marketing', 'assets/images/teamPreview/teamcinque.jpg'),
            ('Design', 'assets/images/teamPreview/teamdue.jpeg'),
            ('QA', 'assets/images/teamPreview/teamquattro.jpg'),
            ('Sales', 'assets/images/teamPreview/teamtre.jpeg'),
            ('Security', 'assets/images/teamPreview/teamuno.jpeg');
          ''');
        await db.rawInsert('''
          INSERT INTO Project (name, description, creationDate, expirationDate, lastModified, status, projectFailureReason, team, thumbnail) VALUES
            ('Project Alpha', 'First development project', '2023-01-01', '2023-12-31', '2023-06-01', 'Attivo', NULL, 'Development', 'assets/images/projectPreview/engineering.jpg'),
            ('Project Beta', 'Marketing campaign for Q1', '2023-02-15', '2023-03-31', '2023-02-20', 'Completato', NULL, 'Marketing', 'assets/images/projectPreview/default.jpg'),
            ('Project Gamma', 'Design new website', '2023-03-01', '2023-09-30', '2023-04-10', 'Attivo', NULL, 'Design', 'assets/images/projectPreview/architectural.jpg'),
            ('Project Delta', 'Quality assurance for new release', '2023-04-01', '2023-06-30', '2023-05-15', 'Fallito', 'Insufficient resources', 'QA', 'assets/images/projectPreview/safety.jpg'),
            ('Project Epsilon', 'Sales strategy for new product', '2023-05-01', '2023-11-30', '2023-05-25', 'Attivo', NULL, 'Sales', 'assets/images/projectPreview/baking.jpg'),
            ('Project Iota', 'Monitoring and mitigating risks related to information security', '2023-05-01', '2023-11-30', '2023-05-25', 'Attivo', NULL, 'Security', 'assets/images/projectPreview/studying.jpg');
          ''');
        await db.rawInsert('''
          INSERT INTO Task (name, completationDate, completed, progress, project) VALUES
            ('Task 1', '2023-01-15', 1, 100.0, 'Project Alpha'),
            ('Task 2', '2023-02-28', 1, 100.0, 'Project Beta'),
            ('Task 3', '2023-04-30', 0, 50.0, 'Project Gamma'),
            ('Task 4', '2023-05-31', 0, 25.0, 'Project Delta'),
            ('Task 5', '2023-06-30', 0, 0.0, 'Project Epsilon'),
            ('Task 6', '2023-04-30', 0, 50.0, 'Project Iota');
          ''');
        await db.rawInsert('''
          INSERT INTO Member (name, surname, role, mainTeam, secondaryTeam) VALUES
            ('Alice', 'Smith', 'Developer', 'Development', 'QA'),
            ('Bob', 'Brown', 'Marketing Specialist', 'Marketing', NULL),
            ('Charlie', 'Davis', 'Designer', 'Design', 'Marketing'),
            ('Diana', 'Evans', 'QA Engineer', 'QA', 'Development'),
            ('Eve', 'Foster', 'Sales Manager', 'Sales', NULL),
            ('Charlotte', 'Gray', 'Sales Specialist', 'Sales', NULL),
            ('John', 'Wick', 'ICT Security Manager', 'Security', NULL),
            ('Jack', 'Reacher', 'Penetration Tester', 'Security', 'Development'),
            ('Tupac', 'Shakur', 'Designer', 'Design', NULL);
          ''');
      },
      version: 1,
    );
  }

  Future<void> insertProject(Project project) async {
    final db = await database;
    await db.insert('Project', project.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('Task', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTeam(Team team) async {
    final db = await database;
    await db.insert('Team', team.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertMember(Member member) async {
    final db = await database;
    await db.insert('Member', member.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> addTeamToMember(int code, String team) async {
    final db = await database;
    await db.update('Member', {'mainTeam': team},
        where: 'code = ?', whereArgs: [code]);
  }

  Future<List<Project>> getProjects() async {
    final db = await database;
    final List<Map<String, Object?>> projectsMaps = await db.query('Project');
    return [
      for (final {
            'name': name as String,
            'description': description as String,
            'creationDate': creationDate as String,
            'expirationDate': expirationDate as String,
            'lastModified': lastModified as String,
            'status': status as String,
            'projectFailureReason': projectFailureReason as String?,
            'team': team as String,
            'thumbnail': thumbnail as String,
          } in projectsMaps)
        Project(
            name: name,
            description: description,
            creationDate: DateTime.parse(creationDate),
            expirationDate: DateTime.parse(expirationDate),
            lastModified: DateTime.parse(lastModified),
            status: status,
            projectFailureReason: projectFailureReason,
            team: await getTeamByName(team),
            thumbnail: AssetImage(thumbnail)),
    ];
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, Object?>> tasksMaps = await db.query('Task');
    return [
      for (final {
            'name': name as String,
            'completationDate': completationDate as String?,
            'completed': completed as int?,
            'progress': progress as double?,
            'project': project as String,
          } in tasksMaps)
        Task(
            name: name,
            completationDate: completationDate != null
                ? DateTime.parse(completationDate)
                : null,
            completed: (completed == 1 ? true : false),
            progress: progress,
            project: await getProjectByName(project)),
    ];
  }

  Future<List<Team>> getTeams() async {
    final db = await database;
    final List<Map<String, Object?>> teamsMaps = await db.query('Team');
    return [
      for (final {
            'name': name as String,
            'thumbnail': thumbnail as String,
          } in teamsMaps)
        Team(name: name, thumbnail: AssetImage(thumbnail)),
    ];
  }

  Future<List<Member>> getMembers() async {
    final db = await database;
    final List<Map<String, Object?>> membersMaps = await db.query('Member');
    return [
      for (final {
            'code': code as int,
            'name': name as String,
            'surname': surname as String,
            'role': role as String,
            'mainTeam': mainTeam as String?,
            'secondaryTeam': secondaryTeam as String?,
          } in membersMaps)
        Member(
            code: code,
            name: name,
            surname: surname,
            role: role,
            mainTeam: await getTeamByName(mainTeam),
            secondaryTeam: await getTeamByName(secondaryTeam)),
    ];
  }

  Future<List<Setting>> getSettings() async {
    final db = await database;
    final List<Map<String, Object?>> settingsMaps = await db.query('Setting');
    return [
      for (final {'name': name as String, 'number': number as int}
          in settingsMaps)
        Setting(name: name, number: number),
    ];
  }

  Future<Project?> getProjectByName(String name) async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.query(
      'Project',
      where: 'name = ?',
      whereArgs: [name],
    );
    if (result.isEmpty) {
      return null;
    }
    final projectMap = result.first;
    return Project(
      name: projectMap['name'] as String,
      description: projectMap['description'] as String,
      creationDate: DateTime.parse(projectMap['creationDate'] as String),
      expirationDate: DateTime.parse(projectMap['expirationDate'] as String),
      lastModified: DateTime.parse(projectMap['lastModified'] as String),
      status: projectMap['status'] as String,
      projectFailureReason: projectMap['projectFailureReason'] as String?,
      team: await getTeamByName(projectMap['team'] as String),
      thumbnail: AssetImage(projectMap['thumbnail'] as String),
    );
  }

  Future<Task?> getTaskByName(String name) async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.query(
      'Task',
      where: 'name = ?',
      whereArgs: [name],
    );
    if (result.isEmpty) {
      return null;
    }
    final taskMap = result.first;
    return Task(
      name: taskMap['name'] as String,
      completationDate: DateTime.parse(taskMap['completationDate'] as String),
      completed: (taskMap['completed'] as int) == 1 ? true : false,
      progress: taskMap['progress'] as double,
      project: await getProjectByName(taskMap['project'] as String),
    );
  }

  Future<Team?> getTeamByName(String? name) async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.query(
      'Team',
      where: 'name = ?',
      whereArgs: [name],
    );
    if (result.isEmpty) {
      return null;
    }
    final teamMap = result.first;
    return Team(
        name: teamMap['name'] as String,
        thumbnail: AssetImage(teamMap['thumbnail'] as String));
  }

  Future<Member?> getMemberByCode(int code) async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.query(
      'Member',
      where: 'code = ?',
      whereArgs: [code],
    );
    if (result.isEmpty) {
      return null;
    }
    final memberMap = result.first;
    return Member(
      code: memberMap['code'] as int,
      name: memberMap['name'] as String,
      surname: memberMap['surname'] as String,
      role: memberMap['role'] as String,
      mainTeam: await getTeamByName(memberMap['mainTeam'] as String?),
      secondaryTeam: await getTeamByName(memberMap['secondaryTeam'] as String?),
    );
  }

  Future<int> getNumTeams() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) as count FROM Team');

    if (result.isNotEmpty) {
      return result.first['count'] as int;
    } else {
      return 0;
    }
  }

  Future<int> getNumMembers() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) as count FROM Member');

    if (result.isNotEmpty) {
      return result.first['count'] as int;
    } else {
      return 0;
    }
  }

  Future<List<int>> getAvgNumMembersPerTeam() async {
    List<Team> teams = await getTeams();
    List<int> numMembersPerTeam = [];
    if(teams == null){
      numMembersPerTeam.add(0);
      return numMembersPerTeam;
    }
    for (final team in teams) {
      final db = await database;
      final List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM Member where mainTeam = ? or secondaryTeam = ?',
        [team.name, team.name],
      );
      if (result.isNotEmpty) {
        numMembersPerTeam.add(result.first['count']);
      }
    }
    return numMembersPerTeam;
  }

  Future<int> getNumProjects() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) as count FROM Project');

    if (result.isNotEmpty) {
      return result.first['count'] as int;
    } else {
      return 0;
    }
  }

  Future<List<double>> getStatusProjects() async{
    List<Project> projects = await getProjects();
    List<double> status = [0,0,0,0]; //attivi-completati-falliti-sospesi
    for (final project in projects){
        if (project.status == "Attivo"){
          status[0] ++;
        }else if(project.status == "Completato"){
          status[1] ++;
        }else if(project.status == "Fallito"){
          status[2] ++;
        }else {
          status[3] ++;
        }
    }
    return status;
  }

  Future<bool> teamExists(String teamName) async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.query(
      'Team',
      where: 'name = ?',
      whereArgs: [teamName],
    );
    return result.isNotEmpty;
  }

  Future<void> assignTeamToMember(String teamName, int code) async {
    final db = await database;
    Member? member = await getMemberByCode(code);
    if (member!.mainTeam == null) {
      await db.update(
        'Member',
        {'mainTeam': teamName},
        where: 'code = ?',
        whereArgs: [code],
      );
    } else if (member.secondaryTeam == null) {
      await db.update(
        'Member',
        {'secondaryTeam': teamName},
        where: 'code = ?',
        whereArgs: [code],
      );
    }
  }

  

  Future<void> assignMainTeamToMember(String teamName, int code) async {
    final db = await database;
    await db.update(
      'Member',
      {'mainTeam': teamName},
      where: 'code = ?',
      whereArgs: [code],
    );
  }

  Future<void> assignSecondaryTeamToMember(String teamName, int code) async {
    final db = await database;
    await db.update(
      'Member',
      {'secondaryTeam': teamName},
      where: 'code = ?',
      whereArgs: [code],
    );
  }

  Future<void> updateTeamName(String oldName, String newName) async {
    final db = await database;
    await db.update('Team', {'name': newName}, where: 'name = ?', whereArgs: [oldName]);
    await db.update(
      'Project',
      {'team': newName, 'lastModified': DateTime.now().toIso8601String()},
      where: 'team = ?',
      whereArgs: [oldName],
    );
  }

  Future<void> updateSetting(String name, int number) async {
    final db = await database;
    await db.update(
      'Setting',
      {'number': number},
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> updateDescription(String project, String newDescription) async {
    final db = await database;
    await db.update(
      'Project',
      {
        'description': newDescription,
        'lastModified': DateTime.now().toIso8601String()
      },
      where: 'name = ?',
      whereArgs: [project],
    );
  }

  Future<void> updateFailureReason(String project, String reason) async {
    final db = await database;
    await db.update('Project', {'projectFailureReason': reason }, where: 'name = ?', whereArgs: [project]);
  }

  Future<void> updateExpirationDate(String project, DateTime newDate) async {
    final db = await database;
    await db.update(
      'Project',
      {
        'expirationDate': newDate.toIso8601String(),
        'lastModified': DateTime.now().toIso8601String()
      },
      where: 'name = ?',
      whereArgs: [project],
    );
  }

  Future<void> updateStatus(String project, String newStatus) async {
    final db = await database;
    await db.update(
      'Project',
      {'status': newStatus, 'lastModified': DateTime.now().toIso8601String()},
      where: 'name = ?',
      whereArgs: [project],
    );
  }

  Future<void> updateTeam(String project, String newTeamName) async {
    final db = await database;
    await db.update(
      'Project',
      {'team': newTeamName, 'lastModified': DateTime.now().toIso8601String()},
      where: 'name = ?',
      whereArgs: [project],
    );
  }

  Future<void> updateThumbnail(String project, String newThumbnail) async {
    final db = await database;
    await db.update(
      'Project',
      {
        'thumbnail': newThumbnail,
        'lastModified': DateTime.now().toIso8601String()
      },
      where: 'name = ?',
      whereArgs: [project],
    );
  }

  Future<void> updateThumbnailTeam(String team, String newThumbnail) async {
    final db = await database;
    await db.update(
      'Team',
      {
        'thumbnail': newThumbnail,
      },
      where: 'name = ?',
      whereArgs: [team],
    );
  }

  Future<void> updateProjectName(String project, String newName) async {
    final db = await database;
    await db.update(
      'Project',
      {'name': newName, 'lastModified': DateTime.now().toIso8601String()},
      where: 'name = ?',
      whereArgs: [project],
    );
  }

  Future<void> updateProjectTeam(String project, String team) async {
    final db = await database;
    await db.update('Project', {'team': team, 'lastModified': DateTime.now().toIso8601String()}, where: 'name = ?', whereArgs: [project]);
    
  }

  Future<void> updateTaskAsCompletedByProjectName(String projectName) async {
    final db = await database;
    await db.update('Task', {'completed': 1},
        where: 'project = ?', whereArgs: [projectName]);
  }

  Future<void> updateTaskName(String oldName, String newName) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT t.project AS project_name FROM Task t WHERE t.name = ?',
      [oldName],
    );
    await db.rawUpdate(
      'UPDATE Project SET lastModified = ? WHERE name = ?',
      [DateTime.now().toIso8601String(), result.first['name'] as String],
    );
    await db.update(
      'Task',
      {'name': newName},
      where: 'name = ?',
      whereArgs: [oldName],
    );
  }

  Future<void> updateCompletationDate(String task, DateTime newDate) async {
    final db = await database;
    await db.update(
      'Task',
      {'completationDate': newDate.toIso8601String()},
      where: 'name = ?',
      whereArgs: [task],
    );
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT t.project AS project_name FROM Task t WHERE t.name = ?',
      [task],
    );
    await db.rawUpdate(
      'UPDATE Project SET lastModified = ? WHERE name = ?',
      [DateTime.now().toIso8601String(), result.first['name'] as String],
    );
  }

  Future<void> updateCompleted(String task, bool isCompleted) async {
    final db = await database;
    await db.update(
      'Task',
      {'completed': isCompleted ? 1 : 0},
      where: 'name = ?',
      whereArgs: [task],
    );
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT t.project AS project_name FROM Task t WHERE t.name = ?',
      [task],
    );
    await db.rawUpdate(
      'UPDATE Project SET lastModified = ? WHERE name = ?',
      [DateTime.now().toIso8601String(), result.first['name'] as String?],
    );
  }

  Future<void> updateProgress(String task, double newProgress) async {
    final db = await database;
    await db.update(
      'Task',
      {'progress': newProgress},
      where: 'name = ?',
      whereArgs: [task],
    );
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT t.project AS project_name FROM Task t WHERE t.name = ?',
      [task],
    );
    await db.rawUpdate(
      'UPDATE Project SET lastModified = ? WHERE name = ?',
      [DateTime.now().toIso8601String(), result.first['name'] as String],
    );
  }

  Future<void> wipeDatabase() async {
    final db = await database;
    await db.delete('Task');
    await db.delete('Team');
    await db.delete('Member');
    await db.delete('Project');
  }

  Future<void> deleteProject(String name) async {
    final db = await database;
    await db.delete(
      'Project',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> deleteProjectByTeam(String teamName) async {
    final db = await database;
    await db.delete('Project', where: 'team = ?', whereArgs: [teamName]);
  }

  Future<void> deleteTask(String name) async {
    final db = await database;
    await db.delete(
      'Task',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> deleteTeam(String name) async {
    final db = await database;
    await db.delete(
      'Team',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> deleteMember(int code) async {
    final db = await database;
    await db.delete(
      'Member',
      where: 'code = ?',
      whereArgs: [code],
    );
  }

  Future<void> removeTeamFromMember(int memberCode, String team) async {
    final db = await database;
    await db.rawUpdate(
        '''UPDATE Member SET mainTeam = CASE WHEN mainTeam = ? THEN NULL ELSE mainTeam END,secondaryTeam = CASE WHEN secondaryTeam = ? THEN NULL ELSE secondaryTeam END WHERE code = ? ''',
        [team, team, memberCode]);
  }

  Future<List<Project>> getActiveProjectsOrderedByLastModified() async {
    final db = await database;
    final List<Map<String, Object?>> projectsMaps = await db.query(
      'Project',
      where: 'status = ?',
      whereArgs: ['Attivo'],
      orderBy: 'lastModified DESC',
    );
    return [
      for (final {
            'name': name as String,
            'description': description as String,
            'creationDate': creationDate as String,
            'expirationDate': expirationDate as String,
            'lastModified': lastModified as String,
            'status': status as String,
            'projectFailureReason': projectFailureReason as String?,
            'team': team as String,
            'thumbnail': thumbnail as String,
          } in projectsMaps)
        Project(
            name: name,
            description: description,
            creationDate: DateTime.parse(creationDate),
            expirationDate: DateTime.parse(expirationDate),
            lastModified: DateTime.parse(lastModified),
            status: status,
            projectFailureReason: projectFailureReason,
            team: await getTeamByName(team),
            thumbnail: AssetImage(thumbnail)),
    ];
  }

  Future<List<Task>> getTasksByProjectName(String project) async {
    final db = await database;
    final List<Map<String, Object?>> tasksMaps = await db.query(
      'Task',
      where: 'project = ?',
      whereArgs: [project],
    );
    return [
      for (final {
            'name': name as String,
            'completationDate': completationDate as String?,
            'completed': completed as int,
            'progress': progress as double,
            'project': project as String,
          } in tasksMaps)
        Task(
          name: name,
          completationDate: completationDate != null
              ? DateTime.parse(completationDate)
              : null,
          completed: completed == 1,
          progress: progress,
          project: await getProjectByName(project),
        ),
    ];
  }

  Future<List<Task>> getUncompletedTasksByProjectName(String project) async {
    final db = await database;
    final List<Map<String, Object?>> tasksMaps = await db.query(
      'Task',
      where: 'project = ? and completed = ?',
      whereArgs: [project, false],
    );
    return [
      for (final {
            'name': name as String,
            'completationDate': completationDate as String?,
            'completed': completed as int,
            'progress': progress as double,
            'project': project as String,
          } in tasksMaps)
        Task(
          name: name,
          completationDate: completationDate != null
              ? DateTime.parse(completationDate)
              : null,
          completed: completed == 1,
          progress: progress,
          project: await getProjectByName(project),
        ),
    ];
  }

  Future<List<Team>> getTeamsOrderedByMemberCount() async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT Team.name, Team.thumbnail, COUNT(Member.code) as memberCount
      FROM Team
      JOIN Member ON Team.name = Member.mainTeam OR Team.name = Member.secondaryTeam
      GROUP BY Team.name
      ORDER BY memberCount DESC
    ''');
    return [
      for (final row in result)
        Team(
            name: row['name'] as String,
            thumbnail: AssetImage(row['thumbnail'] as String)),
    ];
  }

  Future<List<Member>> getMembersByTeam(String team) async {
    final db = await database;
    final List<Map<String, Object?>> membersMaps = await db.query(
      'Member',
      where: 'mainTeam = ? OR secondaryTeam = ?',
      whereArgs: [team, team],
    );
    return [
      for (final memberMap in membersMaps)
        Member(
          code: memberMap['code'] as int,
          name: memberMap['name'] as String,
          surname: memberMap['surname'] as String,
          role: memberMap['role'] as String,
          mainTeam: await getTeamByName(memberMap['mainTeam'] as String?),
          secondaryTeam:
              await getTeamByName(memberMap['secondaryTeam'] as String?),
        ),
    ];
  }

  Future<List<String>> getProjectsByTeam(String teamName) async {
  final db = await database;

  final List<Map<String, Object?>> projectsMaps = await db.query(
    'Project',
    columns: ['name'],
    where: 'status = ? AND team = ?',
    whereArgs: ['Attivo', teamName],
  );

  return projectsMaps.map((project) => project['name'] as String).toList();
}

}
