import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:doctor_booking_flutter/app/common/auth/providers.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/patient/home/providers.dart';
import 'package:doctor_booking_flutter/core/services/add_event_to_calendar.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/widgets/alert_dialog.dart';
import 'package:doctor_booking_flutter/src/widgets/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

@RoutePage(name: 'bookAppointment')
class BookAppointmentScreen extends HookConsumerWidget {
  final Doctor doctor;

  const BookAppointmentScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User currentUser = ref.watch(currentUserProvider)!;
    List<DateTimeRange> converted = [];

    DateTime now = DateTime.now();
    getBookingStream({required DateTime end, required DateTime start}) {
      return ref.watch(doctorScheduleStreamProvider(doctor.emailAddress)).when(
          data: (data) {
            return Stream.value(data);
          },
          error: (e, _) {
            return Stream.value(null);
          },
          loading: () => Stream.value(null));
    }

    Future<dynamic> uploadBooking({required BookingService newBooking}) async {
      /*await Future.delayed(const Duration(seconds: 1));
      converted.value.add(DateTimeRange(
          start: newBooking.bookingStart, end: newBooking.bookingEnd));
      print('${newBooking.toJson()} has been uploaded');*/

      Appointment newAppointment = Appointment(
        bookingStart: newBooking.bookingStart,
        bookingEnd: newBooking.bookingEnd,
        patientId: currentUser.uid,
        userEmail: currentUser.email,
        doctorId: doctor.emailAddress,
        doctorName: doctor.fullName,
        doctorSpeciality: doctor.speciality,
        patientNote: '',
      );
      final result = await ref.read(appointmentRepo).bookDoctorAppointment(
          newAppointment: newAppointment,
          doctor: doctor,
          patientEmail: currentUser.email!);
      result.when(success: (data) {
        //go to home screen
        AutoRouter.of(context).popUntilRoot();
        //add appointment to calendar
        //show dialog to notify user that the appointment has been booked and ask if they want to add it to calendar
        showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: const Text('Booking complete'),
            content: const Text(
                'Your appoint has been booked successfully, do you want to add this appointment to your Calendar?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              FilledButton.tonal(
                onPressed: () async {
                  await CalendarService()
                      .addToCalendar(appointment: newAppointment);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      }, apiFailure: (e, _) {
        //show snackbar to notify user that the appointment failed
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: KText('Appointment booking failed')));
      });
    }

    List<DateTimeRange> convertStreamResult({required dynamic streamResult}) {
      //if the result is doctor and not null, show the doctor's schedule, else show an empty schedule
      if (streamResult is Doctor) {
        converted = streamResult.scheduleRangeList.toList();
        return streamResult.scheduleRangeList;
      } else {
        return [];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: KText(
          'Book appointment',
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: BookingCalendar(
        key: key,
        bookingGridCrossAxisCount: 4,

        getBookingStream: getBookingStream,
        uploadBooking: uploadBooking,
        convertStreamResultToDateTimeRanges: convertStreamResult,

        uploadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        pauseSlotColor: context.outlineVariant,
        //pauseSlotText: pauseSlotText,

        pauseSlots: get120Days(),
        hideBreakTime: false,
        //locale: locale,
        disabledDays: const [6, 7],
        // startingDayOfWeek: 1,
        bookingService: BookingService(
            serviceName: 'Appointments',
            userEmail: currentUser.email,
            userId: currentUser.uid,
            serviceDuration: 30,
            bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
            bookingStart: DateTime(now.year, now.month, now.day, 8, 0)),
      ),
    );
  }
}

///to blank out all 11:30 to 12:30 for the next 120 days
//function that returns a list of DateTimeRange for the next 120 days where the start for each day is 11:30 am and end is 12:30pm
List<DateTimeRange> get120Days() {
  List<DateTimeRange> converted = [];
  DateTime now = DateTime.now();
  for (int i = 0; i < 120; i++) {
    converted.add(DateTimeRange(
        start: DateTime(now.year, now.month, now.day + i, 11, 30),
        end: DateTime(now.year, now.month, now.day + i, 13, 0)));
  }
  return converted;
}
