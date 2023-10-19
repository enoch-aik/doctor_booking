
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor_speciality.dart';
import 'package:doctor_booking_flutter/app/patient/auth/data/models/patient.dart';
import 'package:doctor_booking_flutter/app/patient/home/data/data_source/appointment_datasource.dart';
import 'package:doctor_booking_flutter/app/patient/home/data/data_source/appointment_datasource_impl.dart';
import 'package:doctor_booking_flutter/app/patient/home/data/repo_impl/appointment_repo_impl.dart';
import 'package:doctor_booking_flutter/app/patient/home/domain/repo/appointment_repo.dart';
import 'package:doctor_booking_flutter/core/di/di_providers.dart';
import 'package:doctor_booking_flutter/lib.dart';

final patientSelectedHomeIndex = StateProvider.autoDispose<int>((ref) => 0);
final doctorSelectedHomeIndex = StateProvider.autoDispose<int>((ref) => 0);

final appointmentDataSourceProvider = Provider<AppointmentDataSource>((ref) {
  return AppointmentDataSourceImpl(ref.read(firestoreProvider),
      ref.read(firebaseApiProvider), ref.read(fcmServiceProvider));
});
final appointmentRepoProvider = Provider<AppointmentRepo>(
    (ref) => AppointmentRepoImpl(ref.read(appointmentDataSourceProvider)));

final selectedDoctorSpeciality =
    StateProvider<DoctorSpeciality?>((ref) => null);

final doctorListStreamProvider = StreamProvider<List<Doctor>>((ref) {
  return FirebaseFirestore.instance
      .collection('doctors')
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((e) => Doctor.fromJson(e.data())).toList();
  });
});

final doctorScheduleStreamProvider =
    StreamProvider.family<Doctor, String>((ref, email) {
  return FirebaseFirestore.instance
      .collection('doctors')
      .where('emailAddress', isEqualTo: email)
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs
        .map((e) => Doctor.fromJson(e.data()))
        .toList()
        .first;
  });
});

/// patient data stream provider
final patientAppointmentsStreamProvider =
    StreamProvider.family<Patient, String>((ref, email) {
  return FirebaseFirestore.instance
      .collection('patients')
      .doc(email)
      .snapshots()
      .map((querySnapshot) {
    return Patient.fromJson(querySnapshot.data()!);
  });

  return FirebaseFirestore.instance
      .collection('patients')
      .where('emailAddress', isEqualTo: email)
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs
        .map((e) => Patient.fromJson(e.data()))
        .toList()
        .first;
  });
});

/*
//update doctor's appointment on the database
final updatedDoctorAppointment = FutureProvider.family((ref,Doctor doctor) async{
  try {
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctor.id)
        .update(doctor.toJson());
  } catch (e) {
    log(e.toString());
    rethrow;
  }
});

*/
