import 'package:auto_route/auto_route.dart';
import 'package:doctor_booking_flutter/app/common/auth/providers.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor_speciality.dart';
import 'package:doctor_booking_flutter/app/patient/home/providers.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/constants/assets.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/extensions/date_range.dart';
import 'package:doctor_booking_flutter/src/res/assets/svg.dart';
import 'package:doctor_booking_flutter/src/widgets/loader/loader.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';
import 'package:doctor_booking_flutter/src/widgets/toast/toast.dart';

@RoutePage(name: 'appointmentDetails')
class AppointmentDetailsScreen extends ConsumerWidget {
  final Appointment appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // bool lessThan24HrsToAppointment =
    //     appointment.bookingStart!.difference(DateTime.now()) <
    //         const Duration(hours: 24);

    return Scaffold(
      appBar: AppBar(
        title: KText(
          'Appointment Details',
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            ColSpacing(40.h),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: context.primary,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 110.w,
                        height: 110.w,
                        decoration: BoxDecoration(
                            color: context.tertiaryContainer,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: context.outline)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.asset(AppAssets.getRandomAvatar())),
                      ),
                      RowSpacing(16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText('Dr. ${appointment.doctorName!}',
                              fontSize: 19.sp, fontWeight: FontWeight.w600),
                          KText(
                            '${DoctorSpeciality.getIconFromSpeciality(appointment.doctorSpeciality!)} ${appointment.doctorSpeciality!}',
                            fontSize: 14.sp,
                          ),
                          ColSpacing(4.h),
                          DecoratedBox(
                            decoration: BoxDecoration(
                                color: context.secondaryContainer,
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Padding(
                              padding: EdgeInsets.all(1.w),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                  ),
                                  KText(
                                    '4,5 ',
                                    fontWeight: FontWeight.w500,
                                    color: context.onSecondaryContainer,
                                  )
                                ],
                              ),
                            ),
                          ),
                          ColSpacing(4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: context.outline,
                              ),
                              KText(
                                '800m away',
                                fontSize: 14.sp,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 30,
            ),
            //START AND END DATE
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  'Date',
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w700,
                ),
                ColSpacing(8.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      icCalendar,
                      width: 38.w,
                    ),
                    RowSpacing(16.w),
                    KText(
                      appointment.toDateTimeRange.formatBookingDateTime(),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      // color: context.primary,
                    )
                  ],
                ),
              ],
            ),
            const Divider(
              height: 30,
            ),
            if (appointment.patientNote!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    'Patient Note',
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  ColSpacing(8.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        icNote,
                        width: 38.w,
                      ),
                      RowSpacing(16.w),
                      SizedBox(
                        width: 280.w,
                        child: KText(
                          appointment.patientNote ?? 'No note added',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    height: 30,
                  ),
                ],
              ),
            ColSpacing(200.h),
            SizedBox(
                width: double.maxFinite,
                child: FilledButton(
                    onPressed: () {
                      if (appointment
                          .toDateTimeRange.isLessThan24HrsToAppointment) {
                        //You can only cancel 24 hours before the appointment
                        Toast.error(
                            'You can only cancel 24 hours before the appointment',
                            // 'You can only cancel an appointment 24 hours before cannot cancel this appointment, it is less than 24 hours to the appointment',
                            title: 'Unable to cancel appointment',
                            context);
                      } else {

                        showAdaptiveDialog(
                            context: context,
                            builder: (context) => AlertDialog.adaptive(
                              title: const Text('Cancel appointment'),
                              content: const Text('Are you sure you want to cancel this appointment?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child:  Text('No',style: AppStyle.textStyle.copyWith(color: context.outline),),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Loader.show(context);
                                    final appointmentRepo =
                                    ref.read(appointmentRepoProvider);
                                    final result =
                                    await appointmentRepo.cancelDoctorAppointment(
                                        appointment: appointment,
                                        patientEmail:
                                        ref.watch(currentUserProvider)!.email!);
                                    Loader.hide(context);
                                    result.when(success: (data) {
                                      context.router.popUntilRoot();
                                      Toast.success(
                                        'Appointment cancelled successfully',
                                        context,
                                      );
                                    }, apiFailure: (e, _) {
                                      Navigator.pop(context);
                                      Toast.error('Unexpected error encountered', context,
                                          title: 'Unable to cancel appointment');
                                    });
                                  },
                                  child:  Text('Yes, Cancel',style: AppStyle.textStyle.copyWith(color: context.error),),
                                ),
                              ],
                            ));

                        // get the doctor's fcm token and send a notification

                        // get patients' data and update booking as well
                        // const Uuid().v4()
                      }
                    },
                    child: const Text('Cancel Appointment')))
          ],
        ),
      ),
    );
  }
}
