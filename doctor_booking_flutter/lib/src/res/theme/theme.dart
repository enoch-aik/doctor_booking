import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_scheme.dart';

class AppTheme {
  const AppTheme._();

  // Made for FlexColorScheme version 7.0.5. Make sure you
// use same or higher package version, but still same major version.
// If you use a lower version, some properties may not be supported.
// In that case remove them after copying this theme to your app.
  static final ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.greenM3,
    /*colorScheme: AppColorScheme.lightScheme,
    colors: const FlexSchemeColor(
      primary: Color(0xff065808),
      primaryContainer: Color(0xff9ee29f),
      secondary: Color(0xff365b37),
      secondaryContainer: Color(0xffaebdaf),
      tertiary: Color(0xff2c7e2e),
      tertiaryContainer: Color(0xffb8e6b9),
      appBarColor: Color(0xffb8e6b9),
      error: Color(0xffb00020),
    ),*/
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
      bottomSheetElevation: 0,
      bottomNavigationBarSelectedIconSize: 47.h,
      bottomNavigationBarUnselectedIconSize: 47.h,
      appBarCenterTitle: true,
      textButtonRadius: 8.0,
      filledButtonRadius: 8.0,
      elevatedButtonRadius: 8.0,
      outlinedButtonRadius: 8.0,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedBorderIsColored: false,
      inputDecoratorBorderWidth: 0.5,
      inputDecoratorFocusedBorderWidth: 2,
      cardRadius: 8.0,
      popupMenuRadius: 8.0,
      menuRadius: 8.0,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Gelion',
  );

  static final ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.greenM3,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 13,
    subThemesData: FlexSubThemesData(
      useTextTheme: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
      bottomSheetElevation: 0,
      bottomNavigationBarSelectedIconSize: 47.h,
      bottomNavigationBarUnselectedIconSize: 47.h,
      appBarCenterTitle: true,
      blendOnLevel: 20,
      useM2StyleDividerInM3: true,
      textButtonRadius: 8.0,
      filledButtonRadius: 8.0,
      elevatedButtonRadius: 8.0,
      outlinedButtonRadius: 8.0,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedBorderIsColored: false,
      inputDecoratorBorderWidth: 0.5,
      inputDecoratorFocusedBorderWidth: 2,
      cardRadius: 8.0,
      popupMenuRadius: 8.0,
      menuRadius: 8.0,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Gelion',
  );
}
