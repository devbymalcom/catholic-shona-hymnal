import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/hymn.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  // Create the database and the Post table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'hymnal.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE $hymnalTable('
          'hymnNumber INTEGER,'
          'hymnTitle TEXT NOT NULL,'
          'hymnLyrics TEXT NOT NULL,'
          'hymnAuthor TEXT NOT NULL,'
          'hymnCategory TEXT NOT NULL,'
          'isFavorite BOOLEAN NOT NULL'
          ')');
    });
  }

  // Insert Hymns in database
  createHymnalList(List<Hymn> hymnList) async {
    final db = await database;
    var res;
    for (int i = 0; i < hymnList.length; i++) {
      res = await db.insert(hymnalTable, hymnList[i].toMap());
    }
  }

  Future<Hymn> readHymn(int hymnNumber) async {
    final db = await database;

    final maps = await db.query(
      hymnalTable,
      columns: HymnFields.values,
      where: '${HymnFields.hymnNumber} = ?',
      whereArgs: [hymnNumber],
    );

    if (maps.isNotEmpty) {
      return Hymn.fromMap(maps.first);
    } else {
      throw Exception('ID $hymnNumber not found');
    }
  }

  Future<List<Hymn>> getAllHymns() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM $hymnalTable");
    List<Hymn> list = [];
    for (var c in res.toList()) {
      list.add(Hymn.fromMap(c));
    }
    offlineFetchedList = list;
    return offlineFetchedList;
  }

  Future<int> updateHymn(Hymn hymn) async {
    final db = await database;
    print(hymn.isFavorite);
    // hymn.isFavorite = !hymn.isFavorite;
    // print(hymn.isFavorite);
    Hymn updatedHymn = Hymn(
        hymnNumber: hymn.hymnNumber,
        isFavorite: !hymn.isFavorite,
        hymnTitle: hymn.hymnTitle,
        hymnAuthor: hymn.hymnAuthor,
        hymnCategory: hymn.hymnCategory,
        hymnLyrics: hymn.hymnLyrics);
    print(updatedHymn.isFavorite);

    return db.update(
      hymnalTable,
      updatedHymn.toMap(),
      where: '${HymnFields.hymnNumber} = ?',
      whereArgs: [updatedHymn.hymnNumber],
    );
  }

  Future<int> updateHymnFalse(Hymn hymn) async {
    final db = await database;
    //hymn.isFavorite = !hymn.isFavorite;

    return db.update(
      hymnalTable,
      hymn.toMap(),
      where: '${HymnFields.hymnNumber} = ?',
      whereArgs: [hymn.hymnNumber],
    );
  }

  Future close() async {
    final db = await database;

    db.close();
  }
}
