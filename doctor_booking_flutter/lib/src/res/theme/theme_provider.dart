

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppThemeMode extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ThemeMode.light;
    //return Storage().fetchThemeMode();
  }

  //just for switching them  from light to dark and vice-versa

  void switchTheme() {
    ThemeMode currentTheme = state;
    state = currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    //Storage().saveThemeMode(state);
  }

  void setTheme(ThemeMode theme) {
    state = theme;
   // Storage().saveThemeMode(state);
  }
}
