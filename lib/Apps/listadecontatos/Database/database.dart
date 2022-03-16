// ignore_for_file: avoid_print

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();
  DatabaseHelper.getInstance();

  factory DatabaseHelper() => _instance;

  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'contatos.db');
    print("db $path");

    var db = await openDatabase(path,
        version: 8, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE contatos(id INTEGER PRIMARY KEY, nome TEXT, numero TEXT, numero2 TEXT, email TEXT, endereco TEXT, tipo TEXT)');
  }

  Future<FutureOr<void>> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    print("_onUpgrade: oldVersion: $oldVersion > newVersion: $newVersion");
    // await db.execute("alter table contatos add column numero2 TEXT");
    if (newVersion > oldVersion) {
      print("object");
      // await db.execute("alter table contatos add column numero2 TEXT");
      await db.execute("alter table contatos add column foto TEXT");
    }
  }

  Future close() async {
    var dbClient = await db;
    return dbClient!.close();
  }
}
