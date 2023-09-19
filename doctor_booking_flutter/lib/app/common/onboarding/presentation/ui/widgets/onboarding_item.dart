import 'package:doctor_booking_flutter/app/common/onboarding/data/models/onboarding_model.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(model.imagePath),
        ColSpacing(24.h),

      ],
    );
  }
}
