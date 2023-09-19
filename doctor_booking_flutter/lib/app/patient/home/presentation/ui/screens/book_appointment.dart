import 'package:auto_route/annotations.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';

@RoutePage(name: 'bookAppointment')
class BookAppointmentScreen extends ConsumerWidget {
  final Doctor doctor;

  const BookAppointmentScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime now = DateTime.now();
    Stream<dynamic>? getBookingStream(
        {required DateTime end, required DateTime start}) {
      return Stream.value([]);
    }

    List<DateTimeRange> converted = [];

    Future<dynamic> uploadBooking({required BookingService newBooking}) async {
      await Future.delayed(const Duration(seconds: 1));
      converted.add(DateTimeRange(
          start: newBooking.bookingStart, end: newBooking.bookingEnd));
      print('${newBooking.toJson()} has been uploaded');
    }

    List<DateTimeRange> convertStreamResult({required dynamic streamResult}) {
      DateTime first = now;
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
      return converted;
    }

    return Scaffold(
      appBar: AppBar(),
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
        // uploadingWidget: uploadingWidget,
        pauseSlotColor: context.outlineVariant,
        //pauseSlotText: pauseSlotText,
        pauseSlots: [
          DateTimeRange(
            start: DateTime(now.year, now.month, now.day, 11, 30),
            end: DateTime(now.year, now.month, now.day, 13, 0),
          ),
        ],
        hideBreakTime: false,
        //locale: locale,
        disabledDays: const [6, 7],
        // startingDayOfWeek: startingDayOfWeek,
        bookingService: BookingService(
            serviceName: 'Appointments',
            serviceDuration: 30,
            bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
            bookingStart: DateTime(now.year, now.month, now.day, 8, 0)),
      ),
    );
  }
}
