import 'package:doctor_booking_flutter/app/common/auth/data/data_source/auth_datasource.dart';
import 'package:doctor_booking_flutter/app/common/auth/data/data_source/auth_datasource_impl.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/repo/auth_repo.dart';
import 'package:doctor_booking_flutter/core/helpers/dio_interceptor.dart';
import 'package:doctor_booking_flutter/core/service_result/src/api_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthDataSourceImpl _dataSource;

  AuthRepoImpl(this._dataSource);

  @override
  Future<ApiResult<UserCredential>> googleSignIn() =>
      apiInterceptor(() => _dataSource.googleSignIn());

  @override
  Future<ApiResult<UserCredential>> loginWithEmailAndPassword(UserCred user) =>
      apiInterceptor(() => _dataSource.loginWithEmailAndPassword(user));

  @override
  Future<ApiResult<UserCredential>> signUpWithEmailAndPassword(UserCred user) =>
      apiInterceptor(() => _dataSource.signUpWithEmailAndPassword(user));
}
