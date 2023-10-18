import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/patient/home/data/data_source/appointment_datasource.dart';
import 'package:doctor_booking_flutter/app/patient/home/domain/repo/appointment_repo.dart';
import 'package:doctor_booking_flutter/core/helpers/api_interceptor.dart';
import 'package:doctor_booking_flutter/core/service_result/src/api_result.dart';

class AppointmentRepoImpl extends AppointmentRepo {
  final AppointmentDataSource appointmentDataSource;

  AppointmentRepoImpl(this.appointmentDataSource);

  @override
  Future<ApiResult<bool>> bookDoctorAppointment(
          {required Appointment newAppointment,
          required Doctor doctor,
          required String patientEmail}) =>
      apiInterceptor(() => appointmentDataSource.bookDoctorAppointment(
          newAppointment: newAppointment,
          doctor: doctor,
          patientEmail: patientEmail));

  @override
  Future<ApiResult<bool>> cancelDoctorAppointment(
          {required Appointment appointment, bool isPatient = true}) =>
      apiInterceptor(() => appointmentDataSource.cancelDoctorAppointment(
          appointment: appointment, isPatient: isPatient));
}
