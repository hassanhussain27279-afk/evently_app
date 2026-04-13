import 'package:evently_app/core/utils/Shared_Preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String locale = 'en';
  void changeTheme(ThemeMode newTheme) async {
    if (themeMode == newTheme) return;
    themeMode = newTheme;
    final pref = await SharedPreferences.getInstance();
    pref.setBool(
      SharedPreferencesKeys.isDark.name,
      themeMode == ThemeMode.dark,
    );
    notifyListeners();
  }

  void toggleTheme() async {
    if (isDark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    final pref = await SharedPreferences.getInstance();
    pref.setBool(
      SharedPreferencesKeys.isDark.name,
      themeMode == ThemeMode.dark,
    );
    notifyListeners();
  }

  bool get isDark => themeMode == ThemeMode.dark;

  void changeLocale(String newLocale) async {
    if (locale == newLocale) return;
    locale = newLocale;

    final pref = await SharedPreferences.getInstance();
    pref.setString(SharedPreferencesKeys.local.name, locale);
    notifyListeners();
  }

  void toggleLocale() async {
    if (isEn) {
      locale = 'ar';
    } else {
      locale = 'en';
    }

    final pref = await SharedPreferences.getInstance();
    pref.setString(SharedPreferencesKeys.local.name, locale);
    notifyListeners();
  }

  bool get isEn => locale == 'en';
}
