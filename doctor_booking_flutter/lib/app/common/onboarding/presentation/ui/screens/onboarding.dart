import 'package:auto_route/annotations.dart';
import 'package:doctor_booking_flutter/app/common/onboarding/data/models/onboarding_model.dart';
import 'package:doctor_booking_flutter/app/common/onboarding/presentation/ui/widgets/onboarding_item.dart';
import 'package:doctor_booking_flutter/app/common/onboarding/presentation/ui/widgets/page_indicator.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/constants/assets.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';

@RoutePage(name: 'onboarding')
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  const ColSpacing(80),
                  SizedBox(
                    height: 380.h,
                    child: PageView.builder(
                      itemCount: OnboardingModel.appOnboarding.length,
                      controller: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) => OnboardingItem(
                          model: OnboardingModel.appOnboarding[index]),
                    ),
                  ),
                  OnBoardingPageIndicator(
                      currentPage: currentPage,
                      totalPages: OnboardingModel.appOnboarding.length),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: SizedBox(
                      height: 100.h,
                      child: KText(
                        OnboardingModel.appOnboarding[currentPage].description,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 216.h,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: context.primary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1, color: context.onPrimary),
                          foregroundColor: context.onPrimary),
                      child: Text('Continue as Doctor'),
                    ),
                  ),
                  ColSpacing(10.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Continue as Patient'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
