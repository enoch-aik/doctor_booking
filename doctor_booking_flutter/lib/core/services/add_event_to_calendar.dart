import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/src/extensions/string.dart';

class CalendarService {
  Future<bool> addToCalendar({required Appointment appointment}) async {
    return await Add2Calendar.addEvent2Cal(
      Event(
          title:
              'Appointment with Dr. ${appointment.doctorName!.capitalizeFirstLetter()} (${appointment.doctorSpeciality})',
          startDate: appointment.bookingStart!,
          endDate: appointment.bookingEnd!,
          iosParams: const IOSParams(reminder: Duration(minutes: 30))),
    );
  }
}
