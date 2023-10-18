import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_doctor.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_user.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  ///auth for patient
  Future<UserCredential> patientLogin(UserCred user);

  /// sigin in with google
  Future<UserCredential> googleSignIn();

  /// forget password to reset password
  Future<void> forgotPassword(String email);

  /// signup with email and password
  Future<UserCredential> signUpWithEmailAndPassword(NewUser user);

  ///auth for doctor
  Future<UserCredential> doctorSignUp(NewDoctor doctor);

  /// loqin for doctor
  Future<UserCredential> doctorLogin(UserCred user);

  /// update fcm token to receive notification
  Future<bool> updateFcmToken(
      {required String fcmToken,
      required String email,
      required String userType});
}
