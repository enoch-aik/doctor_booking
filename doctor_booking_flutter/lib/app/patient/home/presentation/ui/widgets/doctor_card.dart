import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/extensions/string.dart';
import 'package:doctor_booking_flutter/src/router/navigator.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: () {
          AppNavigator.of(context).push(DoctorDetails(doctor: doctor));
        },
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: context.onPrimary,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 3,
                    spreadRadius: 0,
                    offset: const Offset(0, 2)),
              ]),
          child: Row(
            children: [
              Container(
                width: 80.w,
                height: 80.w,
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
                    doctor.fullName.capitalizeFirstLetter(),
                    color: context.onTertiaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                  KText(
                    doctor.speciality,
                    color: context.onTertiaryContainer,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
