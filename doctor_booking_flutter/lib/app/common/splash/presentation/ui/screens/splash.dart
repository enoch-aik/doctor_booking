import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:doctor_booking_flutter/src/router/navigator.dart';
import 'package:doctor_booking_flutter/src/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'splash')
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3),(){
AppNavigator.of(context).replace(Login());

    });
  }



  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
