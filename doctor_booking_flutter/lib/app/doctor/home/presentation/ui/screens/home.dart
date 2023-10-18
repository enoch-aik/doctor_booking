
import 'package:auto_route/auto_route.dart';
import 'package:doctor_booking_flutter/app/common/auth/providers.dart';
import 'package:doctor_booking_flutter/app/doctor/home/data/models/custom_appointment.dart';
import 'package:doctor_booking_flutter/app/doctor/profile/presentation/ui/screens/profile.dart';
import 'package:doctor_booking_flutter/app/patient/home/providers.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/constants/app_constants.dart';
import 'package:doctor_booking_flutter/src/extensions/appointment_list.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/extensions/date_range.dart';
import 'package:doctor_booking_flutter/src/res/assets/svg.dart';
import 'package:doctor_booking_flutter/src/widgets/loader/loader.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';
import 'package:doctor_booking_flutter/src/widgets/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

@RoutePage(name: 'doctorHome')
class DoctorHomeScreen extends ConsumerWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<Widget> body = [
      _DoctorHomeView(),
     // DoctorCalendarScreen(),
      DoctorProfileScreen(),
    ];

    return Scaffold(
        body: body[ref.watch(doctorSelectedHomeIndex)],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            onTap: (index) {
              ref.read(doctorSelectedHomeIndex.notifier).state = index;
            },
            currentIndex: ref.watch(doctorSelectedHomeIndex),
            items: doctorAppNavItems,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        )
        /*body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),*/
        );
  }
}

class _DoctorHomeView extends ConsumerWidget {
  const _DoctorHomeView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User currentUser = ref.watch(currentUserProvider)!;
    return Scaffold(
      //appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.only(top: 80.h),
          child:
              ref.watch(doctorScheduleStreamProvider(currentUser.email!)).when(
                  data: (data) {
                    return getScheduleViewCalendar(
                        scheduleViewBuilder: scheduleViewBuilder,
                        context: context,
                        sources: /*_getAppointments()*/
                            data.appointments.toSyncfusionAppointment());
                  },
                  error: (e, _) {
                    return getScheduleViewCalendar(
                        context: context,
                        scheduleViewBuilder: scheduleViewBuilder,
                        sources: []);
                  },
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ))),
    );
  }

  SfCalendar getScheduleViewCalendar(
      {dynamic scheduleViewBuilder,
      required List<CustomAppointment> sources,
      required BuildContext context}) {
    void onAppointmentTap(CalendarTapDetails details) {
      // if (details.appointments!.first.endTime.isAfter(DateTime.now())) {
      CustomAppointment appointment = details.appointments!.first;
      DateTimeRange dateTimeRange =
          DateTimeRange(start: appointment.startTime, end: appointment.endTime);
      showModalBottomSheet(
        context: context,
        builder: (context) => Consumer(builder: (context, ref, child) {
          onCancel(CustomAppointment appointment) async {
            Loader.show(context);
            final appointmentRepo = ref.read(appointmentRepoProvider);
            final result = await appointmentRepo.cancelDoctorAppointment(
                appointment: appointment.appointment, isPatient: false);
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
          }

          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                height: 400.h,
                width: double.maxFinite,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: KText(
                        'Appointment Details',
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: KText(
                        'Date',
                        fontSize: 15.sp,
                      ),
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
                          dateTimeRange.formatBookingDateTime(),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          //color: context.primary,
                        )
                      ],
                    ),
                    ColSpacing(16.h),
                    if (appointment.notes != null &&
                        appointment.notes!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(
                            'Patient Note',
                            fontSize: 15.sp,
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
                                  appointment.notes ?? 'No note added',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ColSpacing(16.h),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'INFO: ',
                              style: AppStyle.textStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.primary)),
                          TextSpan(
                              text:
                                  'You ${dateTimeRange.isPast ? 'had' : 'have'} an ${dateTimeRange.isPast ? '' : dateTimeRange.isOngoing ? 'ongoing' : 'upcoming'} ${appointment.subject} ${dateTimeRange.formatToInfoDateTime()}'),
                        ],
                      ),
                      style: AppStyle.textStyle.copyWith(
                        fontSize: 15.sp,
                        //    color: context.primaryContainer,
                      ),
                      //textAlign: TextAlign.center,
                    ),
                    ColSpacing(24.h),
                    if (!dateTimeRange.isPast)
                      SizedBox(
                        width: double.maxFinite,
                        child: FilledButton(
                            onPressed: () {
                              /*if (dateTimeRange.isLessThan24HrsToAppointment) {
                                Toast.error(
                                    'You can only cancel 24 hours before the appointment',
                                    title: 'Unable to cancel appointment',
                                    context);
                              } else {*/
                                showAdaptiveDialog(
                                  context: context,
                                  builder: (context) => AlertDialog.adaptive(
                                    title: const Text('Delete Appointment'),
                                    content: const Text(
                                        'Are you sure you want to delete this appointment?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            foregroundColor: context.error),
                                        onPressed: () async =>
                                            await onCancel(appointment),
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                           //   }
                            },
                            child: const Text('Cancel Appointment')),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
      //  }
    }

    return SfCalendar(
      showDatePickerButton: true,
      scheduleViewMonthHeaderBuilder: scheduleViewBuilder,
      view: CalendarView.schedule,
      onTap: onAppointmentTap,
      firstDayOfWeek: 1,
      dataSource: _DataSource(sources),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}

Widget scheduleViewBuilder(
    BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
  final String monthName = _getMonthDate(details.date.month);
  return Stack(
    children: <Widget>[
      Image(
          image: ExactAssetImage('assets/images/$monthName.png'),
          fit: BoxFit.cover,
          width: details.bounds.width,
          height: details.bounds.height),
      Positioned(
        left: 55,
        right: 0,
        top: 20,
        bottom: 0,
        child: Text(
          '$monthName ${details.date.year}',
          style: const TextStyle(fontSize: 18),
        ),
      )
    ],
  );
}

/// Returns the month name based on the month value passed from date.
String _getMonthDate(int month) {
  if (month == 01) {
    return 'January';
  } else if (month == 02) {
    return 'February';
  } else if (month == 03) {
    return 'March';
  } else if (month == 04) {
    return 'April';
  } else if (month == 05) {
    return 'May';
  } else if (month == 06) {
    return 'June';
  } else if (month == 07) {
    return 'July';
  } else if (month == 08) {
    return 'August';
  } else if (month == 09) {
    return 'September';
  } else if (month == 10) {
    return 'October';
  } else if (month == 11) {
    return 'November';
  } else {
    return 'December';
  }
}
