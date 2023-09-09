import 'package:doctor_booking_flutter/src/constants/assets.dart';

class OnboardingModel {
  final String imagePath;
  final String description;

  OnboardingModel({required this.imagePath, required this.description});

  static List<OnboardingModel> get appOnboarding => [
        OnboardingModel(
            imagePath: AppAssets.onboarding2,
            description:
                'Welcome to our Doctor Booking App! Get ready to take control of your healthcare journey'),
        OnboardingModel(
            imagePath: AppAssets.onboarding4,
            description:
                'Easily find and book appointments with trusted doctors in just a few taps. Say goodbye to long waiting times and hello to hassle-free appointments.'),
        OnboardingModel(
            imagePath: AppAssets.onboarding3,
            description:
                'Start your journey to better health by finding and booking appointments with top doctors in your area'),
      ];
}
