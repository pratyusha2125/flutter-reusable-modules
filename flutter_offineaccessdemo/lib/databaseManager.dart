import 'dart:async';

import 'package:flutter_offineaccessdemo/Employee.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  //sqfliteFfiInit();
  DatabaseManager._(); // Private constructor to prevent instantiation
  static const _databaseName = "EmployeeDB.db";
  // final documentsDirectory = await getApplicationDocumentsDirectory();
  static final DatabaseManager instance = DatabaseManager.init();
  static Database? _database;

  DatabaseManager.init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase('Employee.db');
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, filePath);
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future<void> insertEmployeeData(Employee employee) async {
    final db = await instance.database;
    // ignore: unused_local_variable
    final id = await db.insert(employeetable, employee.toJson());
  }

  Future<void> deleteData() async {
    final db = await instance.database;
    // ignore: unused_local_variable
    final id = await db.delete(employeetable);
  }

  Future<List<Map<String, dynamic>>> fetchEmployees() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('Employee');
    print(maps);
    return await db.query('Employee');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final designationType = 'TEXT NOT NULL';
    final departmentType = 'TEXT NOT NULL';
    final organizationType = 'TEXT NOT NULL';
    final phoneNumberType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $employeetable(
      ${EmployeeFields.id} $idType,
      ${EmployeeFields.designation} $designationType,
      ${EmployeeFields.department} $departmentType,
      ${EmployeeFields.organization} $organizationType,
      ${EmployeeFields.phoneNumber} $phoneNumberType
    )
  ''');
  }
}
