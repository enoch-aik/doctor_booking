import 'package:auto_route/auto_route.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/common/onboarding/presentation/ui/screens/onboarding.dart';
import 'package:doctor_booking_flutter/app/common/splash/presentation/ui/screens/splash.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/presentation/ui/screens/login.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/presentation/ui/screens/signup.dart';
import 'package:doctor_booking_flutter/app/doctor/calendar/presentation/ui/screens/calendar.dart';
import 'package:doctor_booking_flutter/app/doctor/home/presentation/ui/screens/home.dart';
import 'package:doctor_booking_flutter/app/doctor/profile/presentation/ui/screens/profile.dart';
import 'package:doctor_booking_flutter/app/patient/auth/presentation/ui/screens/login.dart';
import 'package:doctor_booking_flutter/app/patient/auth/presentation/ui/screens/signup.dart';
import 'package:doctor_booking_flutter/app/patient/calendar/presentation/ui/screens/calendar.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/screens/appointment_details.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/screens/book_appointment.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/screens/doctor_details.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/screens/home.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/screens/upcoming_schedules.dart';
import 'package:doctor_booking_flutter/app/patient/profile/presentation/ui/screens/profile.dart';
import 'package:doctor_booking_flutter/app/patient/search/presentation/ui/screens/search.dart';
import 'package:flutter/foundation.dart';

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
        AutoRoute(page: DoctorHome.page),
        AutoRoute(page: PatientCalendar.page),
        AutoRoute(page: PatientSearch.page),
        AutoRoute(page: PatientProfile.page),
        AutoRoute(page: DoctorDetails.page),
        AutoRoute(page: BookAppointment.page),
        AutoRoute(page: UpcomingSchedules.page),
        AutoRoute(page: AppointmentDetails.page),
      ];
}
