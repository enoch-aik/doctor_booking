import 'package:doctor_booking_flutter/app/common/auth/data/data_source/auth_datasource_impl.dart';
import 'package:doctor_booking_flutter/app/common/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:doctor_booking_flutter/core/di/di_providers.dart';
import 'package:doctor_booking_flutter/lib.dart';

final authDataSourceProvider =
    Provider((ref) => AuthDataSourceImpl(ref.watch(firebaseAuthProvider)));

final authRepoProvider =
    Provider((ref) => AuthRepoImpl(ref.watch(authDataSourceProvider)));
