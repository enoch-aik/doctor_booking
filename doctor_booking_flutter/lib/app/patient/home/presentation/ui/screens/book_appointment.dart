import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:doctor_booking_flutter/app/common/auth/providers.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/patient/home/providers.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/widgets/alert_dialog.dart';
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
        patientNote: '',
      );
      final result = await ref.read(appointmentRepo).bookDoctorAppointment(
          newAppointment: newAppointment,
          doctor: doctor,
          patientEmail: currentUser.email!);
      result.when(
          success: (data) {
            AutoRouter.of(context).popUntilRoot();
            showMessageAlertDialog(context,
                text: 'Appointment booked successfully');
          },
          apiFailure: (e, _) {});
    }

    List<DateTimeRange> convertStreamResult({required dynamic streamResult}) {
      //if the result is doctor and not null, show the doctor's schedule, else show an empty schedule
      if (streamResult is Doctor) {
        converted = streamResult.scheduleRangeList.toList();
        return streamResult.scheduleRangeList;
      } else {
        return [];
      }
      /*DateTime first = now;
      DateTime tomorrow = now.add(const Duration(days: 1));
      DateTime second = now.add(const Duration(minutes: 55));
      DateTime third = now.subtract(const Duration(minutes: 240));
      DateTime fourth = now.subtract(const Duration(minutes: 500));
      converted.add(DateTimeRange(
          start: first, end: now.add(const Duration(minutes: 30))));
      converted.add(DateTimeRange(
          start: second, end: second.add(const Duration(minutes: 23))));
      converted.add(DateTimeRange(
          start: third, end: third.add(const Duration(minutes: 15))));
      converted.add(DateTimeRange(
          start: fourth, end: fourth.add(const Duration(minutes: 50))));

      //book whole day example
      converted.add(DateTimeRange(
          start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
          end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
      return converted;*/
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

        //bookingButtonColor: bookingButtonColor,
        //  bookingButtonText: bookingButtonText,
        //  bookingExplanation: bookingExplanation,
        // bookingGridChildAspectRatio: bookingGridChildAspectRatio,
        //  bookingGridCrossAxisCount: bookingGridCrossAxisCount,
        // formatDateTime: formatDateTime,
        // availableSlotColor: availableSlotColor,
        // availableSlotText: availableSlotText,
        // bookedSlotColor: bookedSlotColor,
        // bookedSlotText: bookedSlotText,
        // selectedSlotColor: selectedSlotColor,
        // selectedSlotText: selectedSlotText,
        // gridScrollPhysics: gridScrollPhysics,
        //loadingWidget: loadingWidget,
        //errorWidget: errorWidget,
        uploadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        pauseSlotColor: context.outlineVariant,
        //pauseSlotText: pauseSlotText,

        pauseSlots: get120Days(),
        hideBreakTime: false,
        //locale: locale,
        disabledDays: const [6, 7],
        // startingDayOfWeek: startingDayOfWeek,
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

//create a function that returns a list of DateTimeRange for the next 120 days where the start for each day is 11:30 am and end is 12:30pm
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
