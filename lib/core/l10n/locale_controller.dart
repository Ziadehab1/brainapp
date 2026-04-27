import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController {
  static const _key = 'locale';

  static final ValueNotifier<Locale> locale =
      ValueNotifier(const Locale('ar'));

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'ar';
    locale.value = Locale(code);
  }

  static Future<void> set(Locale l) async {
    locale.value = l;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, l.languageCode);
  }

  static bool get isArabic => locale.value.languageCode == 'ar';
}
