import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:doctor_booking_flutter/core/service_result/src/api_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<ApiResult<UserCredential>> googleSignIn();

  Future<ApiResult<UserCredential>> loginWithEmailAndPassword(UserCred user);

  Future<ApiResult<UserCredential>> signUpWithEmailAndPassword(UserCred user);
  Future<ApiResult<void>> forgotPassword(String email);
}
