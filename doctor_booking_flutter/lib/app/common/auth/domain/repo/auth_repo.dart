import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_doctor.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_user.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:doctor_booking_flutter/core/service_result/src/api_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<ApiResult<UserCredential>> googleSignIn();

  Future<ApiResult<UserCredential>> patientLogin(UserCred user);

  Future<ApiResult<UserCredential>> signUpWithEmailAndPassword(NewUser user);

  Future<ApiResult<UserCredential>> doctorSignUp(NewDoctor doctor);

  Future<ApiResult<UserCredential>> doctorLogin(UserCred user);

  Future<ApiResult<void>> forgotPassword(String email);
}
