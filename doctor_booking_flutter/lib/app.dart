import 'package:auto_route/auto_route.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/observers.dart';
import 'package:doctor_booking_flutter/src/providers.dart';
import 'package:doctor_booking_flutter/src/res/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorBookingApp extends ConsumerWidget {
  const DoctorBookingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouter);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: false,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return MaterialApp.router(
                title: 'Doctor booking',
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: ThemeMode.light,

                routeInformationParser: router.defaultRouteParser(),
                routeInformationProvider: router.routeInfoProvider(),
                routerDelegate: AutoRouterDelegate(
                  router,
                  navigatorObservers: () => [
                    AppRouteObservers(),
                  ],
                )
                //home: const MyHomePage(title: 'Expense tracker'),
                );
          }),
    );
  }
}
