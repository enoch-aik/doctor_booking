import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/core/service_result/service_result.dart';

abstract class AppointmentRepo {
  Future<ApiResult<bool>> bookDoctorAppointment(
      {required Appointment newAppointment,
      required Doctor doctor,
      required String patientEmail});
}
