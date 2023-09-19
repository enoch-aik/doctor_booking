import 'package:auto_route/auto_route.dart';
import 'package:doctor_booking_flutter/app/common/onboarding/presentation/ui/screens/onboarding.dart';
import 'package:doctor_booking_flutter/app/common/splash/presentation/ui/screens/splash.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/presentation/ui/screens/login.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/presentation/ui/screens/signup.dart';
import 'package:doctor_booking_flutter/app/patient/auth/presentation/ui/screens/login.dart';
import 'package:doctor_booking_flutter/app/patient/auth/presentation/ui/screens/signup.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/screens/home.dart';

import '../../app/common/auth/presentation/ui/screens/login.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: Splash.page, initial: true),
        //AUTH
        AutoRoute(page: PatientLogin.page),
        AutoRoute(page: Onboarding.page),
        AutoRoute(page: PatientSignUp.page),
        AutoRoute(page: DoctorLogin.page),
        AutoRoute(page: DoctorSignup.page),
        // HOME
        AutoRoute(page: PatientHome.page),
      ];
}
