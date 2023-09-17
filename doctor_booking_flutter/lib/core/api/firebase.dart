import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_doctor.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApi {
  final FirebaseFirestore firestore;

  FirebaseApi(this.firestore);

  ///add new patient details to patients collection
  Future<bool> storePatientData(
      {required NewUser newUser, required UserCredential credential}) async {
    newUser.userId = credential.user!.uid;
    await firestore
        .collection('patients')
        .doc(credential.user!.email)
        .set(newUser.toJson())
        .onError((error, stackTrace) => false);
    return true;
  }

  ///add new doctor details to doctors collection
  Future<bool> storeDoctorData(
      {required NewDoctor newDoctor,
      required UserCredential credential}) async {
    newDoctor.userId = credential.user!.uid;
    await firestore
        .collection('doctors')
        .doc(credential.user!.email)
        .set(newDoctor.toJson())
        .onError((error, stackTrace) => false);
    return true;
  }

  //check if user exist
  Future<bool> getPatient(String email) async {
    bool exists = false;
    await firestore.collection('patients').doc(email).get();
    return exists;
  }

  //check if doctor exists
  Future<bool> getDoctor(String email) async {
    bool exists = false;
    await firestore.collection('doctors').doc(email).get();
    return exists;
  }

  ///add new doctor details to doctors db
}
