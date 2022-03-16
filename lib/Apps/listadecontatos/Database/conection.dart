import 'dart:async';

import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos.dart';
import 'package:conversormoedas/Apps/listadecontatos/Database/database.dart';

import 'package:sqflite/sqflite.dart';

class ContatosDao {
  Future<Database?> get db => DatabaseHelper.getInstance().db;

  Future<int> save(Contatos contatos) async {
    var dbClient = await db;
    var id = await dbClient!.insert("contatos", contatos.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    // ignore: avoid_print
    print('id: $id');
    return id;
  }

  Future<List<Contatos>> findAll() async {
    final dbClient = await db;

    final list = await dbClient!.rawQuery('select * from contatos');

    final contatos =
        list.map<Contatos>((json) => Contatos.fromJson(json)).toList();

    return contatos;
  }

  Future<List<Contatos>> findAllByTipo(String tipo, String nome) async {
    final dbClient = await db;

    final list = await dbClient!.rawQuery(
        'select * from contatos where tipo = ? and nome like "%$nome%"',
        [tipo]);

    final contatos =
        list.map<Contatos>((json) => Contatos.fromJson(json)).toList();

    return contatos;
  }

  Future<bool> existTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient!
        .rawQuery('select * from contatos where tipo = ?', [tipo]);

    final contatos =
        list.map<Contatos>((json) => Contatos.fromJson(json)).toList();

    return contatos.isNotEmpty;
  }

  Future<Contatos?> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient!.rawQuery('select * from contatos where id = ?', [id]);

    if (list.isNotEmpty) {
      return Contatos.fromJson(list.first);
    }

    return null;
  }

  Future<bool> exists(Contatos contatos) async {
    Contatos? c = await findById(contatos.id);
    var exists = c != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from contatos');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from contatos where id = ?', [id]);
  }

  Future<int> deleteBytipo(String tipo) async {
    var dbClient = await db;
    return await dbClient!
        .rawDelete('delete from contatos where tipo = ?', [tipo]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from contatos');
  }

  Future<int> insertEL(Contatos contatos) async {
    var dbClient = await db;
    return await dbClient!.insert('contatos', contatos.toJson());
  }

  Future<int> update(Contatos contatos) async {
    var dbClient = await db;
    return await dbClient!.update('contatos', contatos.toJson(),
        where: 'id = ?', whereArgs: [contatos.id]);
  }
}
