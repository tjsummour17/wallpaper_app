import 'package:app/src/common/database/sqflite_database.dart';
import 'package:app/src/feature/app/application_material.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteDatabase.init();
  runApp(const ApplicationMaterial());
}
