import 'package:flutter/material.dart';

class Lang {
  static final all = [
    const Locale('ar'),
    const Locale('en'),
  ];

  static String getLangName(String code) {
    switch (code) {
      case 'ar':
        return 'عربي';
      case 'en':
      default:
        return 'English';
    }
  }
}
