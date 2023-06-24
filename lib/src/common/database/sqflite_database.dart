import 'package:app/src/common/models/photo.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class SqfliteDatabase {
  static const _dbName = 'AppDatabase.db';
  static const _dbVersion = 1;
  static const _favTable = 'fav_table';
  static const _appConfigTable = 'app_config_table';
  static const _key = 'key';
  static const _value = '_value';
  static const _langKey = 'lang';
  static const _themeKey = 'theme';

  static late Database _db;

  static Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);
    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_favTable (
                ${Photo.idDbColumn} INTEGER PRIMARY KEY,
                ${Photo.widthDbColumn} INTEGER NOT NULL,
                ${Photo.heightDbColumn} INTEGER NOT NULL,
                ${Photo.urlDbColumn} TEXT NOT NULL,
                ${Photo.photographerDbColumn} TEXT NOT NULL,
                ${Photo.photographerUrlDbColumn} TEXT NOT NULL,
                ${Photo.photographerIdDbColumn} INTEGER NOT NULL,
                ${Photo.avgColorDbColumn} TEXT NOT NULL,
                ${Photo.srcDbColumn} TEXT NOT NULL,
                ${Photo.likedDbColumn} TEXT NOT NULL,
                ${Photo.altDbColumn} TEXT NOT NULL
              );
              ''');
    await db.execute('''
          CREATE TABLE $_appConfigTable (
              $_key VARCHAR(20) PRIMARY KEY,
              $_value VARCHAR(20) NOT NULL
            );
            ''');
    await db.execute('''
          INSERT INTO $_appConfigTable ($_key, $_value)
            VALUES ('$_langKey', 'en');
            ''');
    await db.execute('''
          INSERT INTO $_appConfigTable ($_key, $_value)
            VALUES ('$_themeKey', '${ThemeMode.system.name}');
            ''');
  }

  static Future<void> saveLanguageKey(String langKey) async {
    try {
      await _db.update(
        _appConfigTable,
        {
          _key: _langKey,
          _value: langKey,
        },
        where: '$_key = ?',
        whereArgs: [_langKey],
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<String> getLanguageKey() async {
    try {
      final records = await _db
          .query(_appConfigTable, where: '$_key = ?', whereArgs: [_langKey]);
      if (records.isNotEmpty) {
        return records.first[_value].toString();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return 'en';
  }

  static Future<void> saveTheme(ThemeMode themeMode) async {
    try {
      await _db.update(
        _appConfigTable,
        {
          _key: _themeKey,
          _value: themeMode.name,
        },
        where: '$_key = ?',
        whereArgs: [_themeKey],
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<ThemeMode> getTheme() async {
    try {
      final records = await _db.query(
        _appConfigTable,
        where: '$_key = ?',
        whereArgs: [_themeKey],
      );
      if (records.isNotEmpty) {
        final themeMode = ThemeMode.values.firstWhere(
          (e) => e.name == records.first[_value].toString(),
          orElse: () => ThemeMode.system,
        );
        return themeMode;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return ThemeMode.system;
  }

  static Future<int> addFavPhoto(Photo photo) async {
    return await _db.insert(
      _favTable,
      photo.toSqlJson(),
    );
  }

  static Future<List<Photo>> queryFavorites({
    required int index,
    int limit = 10,
  }) async {
    final results = await _db.query(
      _favTable,
      limit: 10,
      offset: index,
    );
    final List<Photo> photos = [];
    for (final row in results) {
      photos.add(Photo.fromSqlJson(row));
    }
    return photos;
  }

  static Future<int> queryFavCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $_favTable');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  static Future<int> deleteFavPhoto(int id) async {
    return await _db.delete(
      _favTable,
      where: '${Photo.idDbColumn} = ?',
      whereArgs: [id],
    );
  }
}
