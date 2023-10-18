import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/patient/auth/data/models/patient.dart';
import 'package:doctor_booking_flutter/app/patient/home/data/data_source/appointment_datasource.dart';
import 'package:doctor_booking_flutter/core/api/fcm.dart';
import 'package:doctor_booking_flutter/core/api/firebase.dart';
import 'package:doctor_booking_flutter/src/extensions/date_range.dart';

class AppointmentDataSourceImpl extends AppointmentDataSource {
  final FirebaseFirestore firestore;
  final FirebaseApi firebaseApi;
  final FCMService fcmService;

  AppointmentDataSourceImpl(this.firestore, this.firebaseApi, this.fcmService);

  @override
  Future<bool> bookDoctorAppointment(
      {required Appointment newAppointment,
      required Doctor doctor,
      required String patientEmail}) async {
    bool updated = false;
    //update doctors' appointment
    DocumentReference doctorDbRef =
        firestore.collection('doctors').doc(doctor.emailAddress);
    //update patient's appointment
    DocumentReference patientDbRef =
        firestore.collection('patients').doc(patientEmail);

    Patient patient = await firebaseApi.getPatientData(patientEmail);
    await patientDbRef.update({
      'appointments': [newAppointment, ...patient.appointments]
          .map((e) => e.toJson())
          .toList()
    });
    await doctorDbRef.update({
      'appointments': [newAppointment, ...doctor.appointments]
          .map((e) => e.toJson())
          .toList()
    });
    updated = true;

    //send notification to doctor
    try {
      await fcmService.sendNotification(
          recipientFCMToken: doctor.fcmToken!,
          body:
              '${newAppointment.patientName!} just booked an appointment with you ${newAppointment.toDateTimeRange.formatToInfoDateTime()}',
          title: 'You have a new appointment!');
    } catch (_) {}

    return updated;
  }

  @override
  Future<bool> cancelDoctorAppointment(
      {required Appointment appointment, bool isPatient = true}) async {
    bool updated = false;
    //update doctors' appointment
    DocumentReference doctorDbRef =
        firestore.collection('doctors').doc(appointment.doctorEmail!);
    //update patient's appointment
    DocumentReference patientDbRef =
        firestore.collection('patients').doc(appointment.patientEmail!);
    //get patient's data
    Patient patient =
        await firebaseApi.getPatientData(appointment.patientEmail!);

    Doctor doctor = await firebaseApi.getDoctorData(appointment.doctorEmail!);
    //remove appointment from patient's appointment list
    patient.appointments.removeWhere((element) => element == appointment);

    await patientDbRef.update({
      'appointments': [...patient.appointments].map((e) => e.toJson()).toList()
    });

    //remove appointment from doctor's appointment list
    doctor.appointments.removeWhere((element) => element == appointment);
    await doctorDbRef.update({
      'appointments': [...doctor.appointments].map((e) => e.toJson()).toList()
    });
    updated = true;

    //send notification to doctor
    try {
      await fcmService.sendNotification(
          recipientFCMToken: isPatient ? doctor.fcmToken! : patient.fcmToken!,
          body:
              'You appointment with ${appointment.patientName!} ${appointment.toDateTimeRange.formatToInfoDateTime()} has been cancelled',
          title: 'Appointment cancelled');
    } catch (_) {}

    return updated;
  }
}
