import 'package:sqflite/sqflite.dart';
import 'package:flutter_application/classes/sql_classes/sqlite_class_all.dart';
import 'package:flutter_application/data/database_helper.dart';

class MemberDao {
  MemberDao._privateConstructor();
  static final MemberDao instance = MemberDao._privateConstructor();

  Future<void> insertMember(Member member) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'Member',
      member.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Member>> getAllMembers() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('Member');

    return List.generate(maps.length, (i) {
      return Member.fromMap(maps[i]);
    });
  }

  // Altre operazioni, come update, delete, ecc.
}
