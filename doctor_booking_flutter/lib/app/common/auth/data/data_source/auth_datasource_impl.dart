import 'package:doctor_booking_flutter/app/common/auth/data/data_source/auth_datasource.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final FirebaseAuth auth;

  AuthDataSourceImpl(this.auth);

  /// login with google
  @override
  Future<UserCredential> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // get auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // when signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  ///login with email and password
  @override
  Future<UserCredential> loginWithEmailAndPassword(UserCred user) async {
    return await auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  /// signup with email and password
  @override
  Future<UserCredential> signUpWithEmailAndPassword(UserCred user) async {
    return await auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
  }
}
