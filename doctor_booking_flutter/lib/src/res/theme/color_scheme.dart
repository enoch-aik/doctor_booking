// Light and dark ColorSchemes made by FlexColorScheme v7.0.5.
// These ColorScheme objects require Flutter 3.7 or later.
import 'package:flutter/material.dart';

class AppColorScheme {
  const AppColorScheme._();


  static const ColorScheme lightScheme = ColorScheme(brightness: Brightness.light,
    primary: Color(0xff006e1c),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xffb6f2af),
    onPrimaryContainer: Color(0xff0f140f),
    secondary: Color(0xff36855e),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffc0ffd8),
    onSecondaryContainer: Color(0xff101412),
    tertiary: Color(0xff00658c),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xffc5e7ff),
    onTertiaryContainer: Color(0xff111314),
    error: Color(0xffba1a1a),
    onError: Color(0xffffffff),
    errorContainer: Color(0xffffdad6),
    onErrorContainer: Color(0xff141212),
    background: Color(0xfff8fbf8),
    onBackground: Color(0xff090909),
    surface: Color(0xfff8fbf8),
    onSurface: Color(0xff090909),
    surfaceVariant: Color(0xffe0e6e2),
    onSurfaceVariant: Color(0xff111211),
    outline: Color(0xff7c7c7c),
    outlineVariant: Color(0xffc8c8c8),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff101311),
    onInverseSurface: Color(0xfff5f5f5),
    inversePrimary: Color(0xff8edfa3),
    surfaceTint: Color(0xff006e1c),
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff7edb7b),
    onPrimary: Color(0xff0d140d),
    primaryContainer: Color(0xff005313),
    onPrimaryContainer: Color(0xffdfece2),
    secondary: Color(0xffa3f4c5),
    onSecondary: Color(0xff101413),
    secondaryContainer: Color(0xff003822),
    onSecondaryContainer: Color(0xffdfe8e5),
    tertiary: Color(0xff87cffb),
    onTertiary: Color(0xff0e1414),
    tertiaryContainer: Color(0xff004c6a),
    onTertiaryContainer: Color(0xffdfebf0),
    error: Color(0xffffb4ab),
    onError: Color(0xff141211),
    errorContainer: Color(0xff93000a),
    onErrorContainer: Color(0xfff6dfe1),
    background: Color(0xff161b16),
    onBackground: Color(0xffecedec),
    surface: Color(0xff161b16),
    onSurface: Color(0xffecedec),
    surfaceVariant: Color(0xff394339),
    onSurfaceVariant: Color(0xffdfe1df),
    outline: Color(0xff767d76),
    outlineVariant: Color(0xff2c2e2c),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xfff8fdf8),
    onInverseSurface: Color(0xff131313),
    inversePrimary: Color(0xff446d43),
    surfaceTint: Color(0xff7edb7b),
  );

}

