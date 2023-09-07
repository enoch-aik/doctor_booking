
import 'package:auto_route/annotations.dart';
import 'package:doctor_booking_flutter/lib.dart';

@RoutePage(name: 'onboarding')
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( body: SingleChildScrollView(child: Column(children: [
      SizedBox(height: 560.h,child: PageView(children: [



      ],),)


    ],),),);
  }
}
