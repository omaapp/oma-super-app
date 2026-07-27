import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale("ar");

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    final dark = prefs.getBool("darkMode") ?? false;
    final lang = prefs.getString("language") ?? "ar";

    _themeMode =
        dark ? ThemeMode.dark : ThemeMode.light;

    _locale = Locale(lang);

    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("darkMode", value);

    _themeMode =
        value ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("language", code);

    _locale = Locale(code);

    notifyListeners();
  }
}