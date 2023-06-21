import 'package:app/src/common/database/sqflite_database.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    _themeMode = value;
    SqfliteDatabase.saveTheme(value);
    notifyListeners();
  }
}
