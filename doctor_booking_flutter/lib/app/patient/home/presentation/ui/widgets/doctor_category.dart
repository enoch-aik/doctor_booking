import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor_speciality.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';

class DoctorCategoryCard extends StatelessWidget {
  final DoctorSpeciality speciality;
  final void Function()? onTap;
  final bool isSelected;

  const DoctorCategoryCard(
      {super.key, required this.speciality, required this.onTap,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w, bottom: 8.h, top: 4),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(duration: const Duration(milliseconds: 600),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: isSelected?context.secondary: context.surface,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 3,
                    spreadRadius: 0,
                    offset: const Offset(0, 2)),
              ]),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              KText(speciality.icon),
              RowSpacing(8.w),
              KText(
                speciality.title,color: isSelected?context.onSecondary:null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
