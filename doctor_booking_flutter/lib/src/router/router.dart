import 'package:auto_route/auto_route.dart';
import 'package:doctor_booking_flutter/app/common/onboarding/presentation/ui/screens/onboarding.dart';
import 'package:doctor_booking_flutter/app/common/splash/presentation/ui/screens/splash.dart';

import '../../app/common/auth/presentation/ui/screens/login.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: Splash.page, initial: true),
        AutoRoute(page: Login.page,),
        AutoRoute(page: Onboarding.page,),
      ];
}
