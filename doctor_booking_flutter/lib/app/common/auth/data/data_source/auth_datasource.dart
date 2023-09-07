import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {

  Future<UserCredential> loginWithEmailAndPassword(UserCred user);
  Future<UserCredential> googleSignIn();
  Future<UserCredential> signUpWithEmailAndPassword(UserCred user);

}