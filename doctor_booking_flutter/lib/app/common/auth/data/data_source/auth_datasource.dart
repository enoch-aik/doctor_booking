import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_doctor.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_user.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  ///auth for patient
  Future<UserCredential> patientLogin(UserCred user);

  Future<UserCredential> googleSignIn();

  Future<void> forgotPassword(String email);

  Future<UserCredential> signUpWithEmailAndPassword(NewUser user);

  ///auth for doctor
  Future<UserCredential> doctorSignUp(NewDoctor doctor);

  Future<UserCredential> doctorLogin(UserCred user);
}
