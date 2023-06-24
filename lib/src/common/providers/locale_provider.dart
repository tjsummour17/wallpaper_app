import 'dart:io';

import 'package:app/src/common/api/client.dart';
import 'package:app/src/common/database/sqflite_database.dart';
import 'package:app/src/common/lang/lang.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  List<Locale> locales = Lang.all;
  bool isConnectedToInternet = true;
  Locale _locale = const Locale('en');

  String get localeName => Lang.getLangName(_locale.languageCode);

  Locale get locale => _locale;

  Future<void> init() async {
    _locale = Locale(await SqfliteDatabase.getLanguageKey());
    notifyListeners();
  }

  String localeNameByLangCode(String languageCode) =>
      Lang.getLangName(languageCode);

  void setLocale(Locale locale) {
    if (!Lang.all.contains(locale)) return;
    _locale = locale;
    SqfliteDatabase.saveLanguageKey(locale.languageCode);
    notifyListeners();
  }

  Future checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(baseUrl);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnectedToInternet = true;
      } else {
        isConnectedToInternet = false;
      }
    } catch (_) {
      isConnectedToInternet = false;
    }
    notifyListeners();
  }
}
