import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart'
    as syncfusion_appointment;

class CustomAppointment extends syncfusion_appointment.Appointment {
  final Appointment appointment;

  CustomAppointment(
      {required this.appointment,
      required super.startTime,
      required super.endTime,
      required super.subject,
      required super.notes,
      required super.color})
      : super();
}
