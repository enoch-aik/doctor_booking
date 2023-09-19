import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor_speciality.dart';
import 'package:doctor_booking_flutter/lib.dart';

final selectedHomeIndex = StateProvider<int>((ref) => 0);

final selectedDoctorSpeciality =
    StateProvider<DoctorSpeciality?>((ref) => null);

final doctorStreamProvider = StreamProvider<List<Doctor>>((ref) {
  return FirebaseFirestore.instance
      .collection('doctors')
      .snapshots()
      .map((querySnapshot) {
    List docs = querySnapshot.docs;

    List<Doctor> doctors = [];
    for (var doc in docs) {
      doctors.add(Doctor.fromJson(doc.data()));
    }
    return doctors.where((element) => element.isApproved).toList();
  });
});
