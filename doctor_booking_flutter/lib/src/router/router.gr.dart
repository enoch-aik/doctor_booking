// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AppointmentDetails.name: (routeData) {
      final args = routeData.argsAs<AppointmentDetailsArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AppointmentDetailsScreen(
          key: args.key,
          appointment: args.appointment,
        ),
      );
    },
    BookAppointment.name: (routeData) {
      final args = routeData.argsAs<BookAppointmentArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BookAppointmentScreen(
          key: args.key,
          doctor: args.doctor,
        ),
      );
    },
    DoctorCalendar.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DoctorCalendarScreen(),
      );
    },
    DoctorDetails.name: (routeData) {
      final args = routeData.argsAs<DoctorDetailsArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DoctorDetailsScreen(
          key: args.key,
          doctor: args.doctor,
          doctorImage: args.doctorImage,
        ),
      );
    },
    DoctorHome.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DoctorHomeScreen(),
      );
    },
    DoctorLogin.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DoctorLoginScreen(),
      );
    },
    DoctorProfile.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DoctorProfileScreen(),
      );
    },
    DoctorSignup.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DoctorSignupScreen(),
      );
    },
    Login.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    Onboarding.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingScreen(),
      );
    },
    PatientCalendar.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PatientCalendarScreen(),
      );
    },
    PatientHome.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PatientHomeScreen(),
      );
    },
    PatientLogin.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PatientLoginScreen(),
      );
    },
    PatientProfile.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PatientProfileScreen(),
      );
    },
    PatientSearch.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PatientSearchScreen(),
      );
    },
    PatientSignUp.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PatientSignUpScreen(),
      );
    },
    Settings.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    Splash.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    UpcomingSchedules.name: (routeData) {
      final args = routeData.argsAs<UpcomingSchedulesArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UpcomingSchedulesScreen(
          key: args.key,
          appointments: args.appointments,
        ),
      );
    },
  };
}

/// generated route for
/// [AppointmentDetailsScreen]
class AppointmentDetails extends PageRouteInfo<AppointmentDetailsArgs> {
  AppointmentDetails({
    Key? key,
    required Appointment appointment,
    List<PageRouteInfo>? children,
  }) : super(
          AppointmentDetails.name,
          args: AppointmentDetailsArgs(
            key: key,
            appointment: appointment,
          ),
          initialChildren: children,
        );

  static const String name = 'AppointmentDetails';

  static const PageInfo<AppointmentDetailsArgs> page =
      PageInfo<AppointmentDetailsArgs>(name);
}

class AppointmentDetailsArgs {
  const AppointmentDetailsArgs({
    this.key,
    required this.appointment,
  });

  final Key? key;

  final Appointment appointment;

  @override
  String toString() {
    return 'AppointmentDetailsArgs{key: $key, appointment: $appointment}';
  }
}

/// generated route for
/// [BookAppointmentScreen]
class BookAppointment extends PageRouteInfo<BookAppointmentArgs> {
  BookAppointment({
    Key? key,
    required Doctor doctor,
    List<PageRouteInfo>? children,
  }) : super(
          BookAppointment.name,
          args: BookAppointmentArgs(
            key: key,
            doctor: doctor,
          ),
          initialChildren: children,
        );

  static const String name = 'BookAppointment';

  static const PageInfo<BookAppointmentArgs> page =
      PageInfo<BookAppointmentArgs>(name);
}

class BookAppointmentArgs {
  const BookAppointmentArgs({
    this.key,
    required this.doctor,
  });

  final Key? key;

  final Doctor doctor;

  @override
  String toString() {
    return 'BookAppointmentArgs{key: $key, doctor: $doctor}';
  }
}

/// generated route for
/// [DoctorCalendarScreen]
class DoctorCalendar extends PageRouteInfo<void> {
  const DoctorCalendar({List<PageRouteInfo>? children})
      : super(
          DoctorCalendar.name,
          initialChildren: children,
        );

  static const String name = 'DoctorCalendar';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DoctorDetailsScreen]
class DoctorDetails extends PageRouteInfo<DoctorDetailsArgs> {
  DoctorDetails({
    Key? key,
    required Doctor doctor,
    required String doctorImage,
    List<PageRouteInfo>? children,
  }) : super(
          DoctorDetails.name,
          args: DoctorDetailsArgs(
            key: key,
            doctor: doctor,
            doctorImage: doctorImage,
          ),
          initialChildren: children,
        );

  static const String name = 'DoctorDetails';

  static const PageInfo<DoctorDetailsArgs> page =
      PageInfo<DoctorDetailsArgs>(name);
}

class DoctorDetailsArgs {
  const DoctorDetailsArgs({
    this.key,
    required this.doctor,
    required this.doctorImage,
  });

  final Key? key;

  final Doctor doctor;

  final String doctorImage;

  @override
  String toString() {
    return 'DoctorDetailsArgs{key: $key, doctor: $doctor, doctorImage: $doctorImage}';
  }
}

/// generated route for
/// [DoctorHomeScreen]
class DoctorHome extends PageRouteInfo<void> {
  const DoctorHome({List<PageRouteInfo>? children})
      : super(
          DoctorHome.name,
          initialChildren: children,
        );

  static const String name = 'DoctorHome';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DoctorLoginScreen]
class DoctorLogin extends PageRouteInfo<void> {
  const DoctorLogin({List<PageRouteInfo>? children})
      : super(
          DoctorLogin.name,
          initialChildren: children,
        );

  static const String name = 'DoctorLogin';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DoctorProfileScreen]
class DoctorProfile extends PageRouteInfo<void> {
  const DoctorProfile({List<PageRouteInfo>? children})
      : super(
          DoctorProfile.name,
          initialChildren: children,
        );

  static const String name = 'DoctorProfile';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DoctorSignupScreen]
class DoctorSignup extends PageRouteInfo<void> {
  const DoctorSignup({List<PageRouteInfo>? children})
      : super(
          DoctorSignup.name,
          initialChildren: children,
        );

  static const String name = 'DoctorSignup';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class Login extends PageRouteInfo<void> {
  const Login({List<PageRouteInfo>? children})
      : super(
          Login.name,
          initialChildren: children,
        );

  static const String name = 'Login';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingScreen]
class Onboarding extends PageRouteInfo<void> {
  const Onboarding({List<PageRouteInfo>? children})
      : super(
          Onboarding.name,
          initialChildren: children,
        );

  static const String name = 'Onboarding';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PatientCalendarScreen]
class PatientCalendar extends PageRouteInfo<void> {
  const PatientCalendar({List<PageRouteInfo>? children})
      : super(
          PatientCalendar.name,
          initialChildren: children,
        );

  static const String name = 'PatientCalendar';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PatientHomeScreen]
class PatientHome extends PageRouteInfo<void> {
  const PatientHome({List<PageRouteInfo>? children})
      : super(
          PatientHome.name,
          initialChildren: children,
        );

  static const String name = 'PatientHome';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PatientLoginScreen]
class PatientLogin extends PageRouteInfo<void> {
  const PatientLogin({List<PageRouteInfo>? children})
      : super(
          PatientLogin.name,
          initialChildren: children,
        );

  static const String name = 'PatientLogin';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PatientProfileScreen]
class PatientProfile extends PageRouteInfo<void> {
  const PatientProfile({List<PageRouteInfo>? children})
      : super(
          PatientProfile.name,
          initialChildren: children,
        );

  static const String name = 'PatientProfile';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PatientSearchScreen]
class PatientSearch extends PageRouteInfo<void> {
  const PatientSearch({List<PageRouteInfo>? children})
      : super(
          PatientSearch.name,
          initialChildren: children,
        );

  static const String name = 'PatientSearch';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PatientSignUpScreen]
class PatientSignUp extends PageRouteInfo<void> {
  const PatientSignUp({List<PageRouteInfo>? children})
      : super(
          PatientSignUp.name,
          initialChildren: children,
        );

  static const String name = 'PatientSignUp';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class Settings extends PageRouteInfo<void> {
  const Settings({List<PageRouteInfo>? children})
      : super(
          Settings.name,
          initialChildren: children,
        );

  static const String name = 'Settings';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class Splash extends PageRouteInfo<void> {
  const Splash({List<PageRouteInfo>? children})
      : super(
          Splash.name,
          initialChildren: children,
        );

  static const String name = 'Splash';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UpcomingSchedulesScreen]
class UpcomingSchedules extends PageRouteInfo<UpcomingSchedulesArgs> {
  UpcomingSchedules({
    Key? key,
    required List<Appointment> appointments,
    List<PageRouteInfo>? children,
  }) : super(
          UpcomingSchedules.name,
          args: UpcomingSchedulesArgs(
            key: key,
            appointments: appointments,
          ),
          initialChildren: children,
        );

  static const String name = 'UpcomingSchedules';

  static const PageInfo<UpcomingSchedulesArgs> page =
      PageInfo<UpcomingSchedulesArgs>(name);
}

class UpcomingSchedulesArgs {
  const UpcomingSchedulesArgs({
    this.key,
    required this.appointments,
  });

  final Key? key;

  final List<Appointment> appointments;

  @override
  String toString() {
    return 'UpcomingSchedulesArgs{key: $key, appointments: $appointments}';
  }
}
