import 'package:doctor_booking_flutter/app/common/auth/data/data_source/auth_datasource_impl.dart';
import 'package:doctor_booking_flutter/app/common/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:doctor_booking_flutter/core/di/di_providers.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:firebase_auth/firebase_auth.dart';

///This is the provider for the auth datasource
final authDataSourceProvider = Provider((ref) => AuthDataSourceImpl(ref));


///This is the provider for the auth repo
final authRepoProvider =
    Provider((ref) => AuthRepoImpl(ref.watch(authDataSourceProvider)));
//This boolean is used to get there is a current user, this is true if there is a current user and false if there is no current user
final isLoggedIn = StateProvider<bool>((ref) {
  return ref.watch(firebaseAuthProvider).currentUser != null;
});

//This is used to get the details of the current User, if there is no user, this would be null
final currentUserProvider = StateProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).currentUser;
});

