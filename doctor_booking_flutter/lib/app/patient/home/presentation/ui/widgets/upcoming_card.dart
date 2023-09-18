import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';

class UpcomingScheduleCard extends StatelessWidget {
  const UpcomingScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 188.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding:
            EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
            height: 172.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: context.primary),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: context.tertiaryContainer,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    RowSpacing(16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          'Doctor\'s name',
                          color: context.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        ColSpacing(2.h),
                        KText(
                          'Speciality',
                          color: context.surface,
                          fontSize: 14.sp,
                        )
                      ],
                    ),
                  ],
                ),
                ColSpacing(20.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: context.inversePrimary.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Row(
                    children: [
                      const Icon(Icons.watch_later_outlined),
                      RowSpacing(8.w),
                      KText(
                        'Sun, Jan 15, 9:00 - 12:00',
                        color: context.onSecondaryContainer,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 8),
              child: Container(
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: context.primary.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Container(
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: context.primary.withOpacity(0.2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
