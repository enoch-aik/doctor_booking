import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';

abstract class AppointmentDataSource {
  // book doctor's appointment
  Future<bool> bookDoctorAppointment(
      {required Appointment newAppointment,
      required Doctor doctor,
      required String patientEmail});

  Future<bool> cancelDoctorAppointment(
      {required Appointment appointment,bool isPatient = true});


}
