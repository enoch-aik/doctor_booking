import 'package:doctor_booking_flutter/app/common/auth/data/data_source/auth_datasource_impl.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_doctor.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_user.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/repo/auth_repo.dart';
import 'package:doctor_booking_flutter/core/helpers/api_interceptor.dart';
import 'package:doctor_booking_flutter/core/service_result/src/api_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthDataSourceImpl _dataSource;

  AuthRepoImpl(this._dataSource);

  @override
  Future<ApiResult<UserCredential>> googleSignIn() =>
      apiInterceptor(() => _dataSource.googleSignIn());

  @override
  Future<ApiResult<UserCredential>> patientLogin(UserCred user) =>
      apiInterceptor(() => _dataSource.patientLogin(user));

  @override
  Future<ApiResult<UserCredential>> signUpWithEmailAndPassword(NewUser user) =>
      apiInterceptor(() => _dataSource.signUpWithEmailAndPassword(user));

  @override
  Future<ApiResult<void>> forgotPassword(String email) =>
      apiInterceptor(() => _dataSource.forgotPassword(email));

  @override
  Future<ApiResult<UserCredential>> doctorSignUp(NewDoctor doctor) =>
      apiInterceptor(() => _dataSource.doctorSignUp(doctor));

  @override
  Future<ApiResult<UserCredential>> doctorLogin(UserCred user) =>
      apiInterceptor(() => _dataSource.doctorLogin(user));

  @override
  Future<ApiResult<bool>> updateFcmToken(
          {required String fcmToken,
          required String email,
          required String userType}) =>
      apiInterceptor(() => _dataSource.updateFcmToken(
          fcmToken: fcmToken, email: email, userType: userType));
}
