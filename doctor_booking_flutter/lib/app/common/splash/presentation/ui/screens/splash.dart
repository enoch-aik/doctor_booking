import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:doctor_booking_flutter/app/common/auth/providers.dart'
    hide isLoggedIn;
import 'package:doctor_booking_flutter/core/di/di_providers.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/router/navigator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@RoutePage(name: 'splash')
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //check if the app has a current user
    bool hasCurrentUser = ref.read(isLoggedIn.notifier).state;
    bool hasUserData = ref.read(storeProvider).fetchUserType() != null;
    final authRepo = ref.read(authDataSourceProvider);

    Future.delayed(const Duration(seconds: 2), () async {
      if (hasCurrentUser && hasUserData) {
        //Check if the current user is a doctor or patient
        String userType = ref.read(storeProvider).fetchUserType()!;
        String? fcmToken = '';
        if(Platform.isAndroid){
           fcmToken = await FirebaseMessaging.instance.getToken();
        }
        await authRepo.updateFcmToken(
            fcmToken: fcmToken!,
            email: ref.read(currentUserProvider.notifier).state!.email!,
            userType: userType);

        userType.contains('patient')
            ? AppNavigator.of(context).replace(const PatientHome())
            : AppNavigator.of(context).replace(const DoctorHome());
      } else {
        AppNavigator.of(context).replace(const Onboarding());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
