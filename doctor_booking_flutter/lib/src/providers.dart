
import 'package:doctor_booking_flutter/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouter  = Provider((ref) => AppRouter());

///provider for the app's themeMode

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);