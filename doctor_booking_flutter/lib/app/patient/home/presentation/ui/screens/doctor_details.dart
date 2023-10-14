import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/constants/assets.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/extensions/string.dart';
import 'package:doctor_booking_flutter/src/router/navigator.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';

@RoutePage(name: 'doctorDetails')
class DoctorDetailsScreen extends ConsumerWidget {
  const DoctorDetailsScreen({super.key, required this.doctor,required this.doctorImage});

  final Doctor doctor;
  final String doctorImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: KText(
          'Doctor details',
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          ColSpacing(24.h),
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: context.primaryContainer,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child:  ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(doctorImage))
                  ),
                  RowSpacing(16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        doctor.fullName.capitalizeFirstLetter(),
                        // color: context.onPrimary,
                        fontWeight: FontWeight.w500, fontSize: 18.sp,
                      ),
                      ColSpacing(2.h),
                      KText(
                        doctor.speciality,
                        color: context.outline,
                        fontSize: 14.sp,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          ColSpacing(40.h),
          Container(
            padding: EdgeInsets.all(16.w),
            //height: 400.h,
            decoration: BoxDecoration(
              color: context.background,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                    color: context.outline.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 16)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  'Biography',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: context.primary,
                ),
                ColSpacing(8.h),
                KText(
                    '${doctor.fullName.capitalizeFirstLetter()} is a professional '
                    '${doctor.speciality} in Sweden. He practices'
                    ' general at Elisabeth Hospital in Semarang ...')
              ],
            ),
          )
        ],
      ),
      bottomSheet: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.only(bottom: 16.h, right: 16.w, left: 16.w),
          child: FilledButton(
              onPressed: () {
                AppNavigator.of(context).push(BookAppointment(doctor: doctor));
              },
              child: Text('Book Appointment')),
        ),
      ),
    );
  }
}
