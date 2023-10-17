import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_flutter/app/common/auth/data/data_source/auth_datasource.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_doctor.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_user.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/core/api/firebase.dart';
import 'package:doctor_booking_flutter/core/di/di_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final Ref _ref;
  late final FirebaseAuth auth;
  late final FirebaseApi firebaseApi;
  late final FirebaseFirestore firestore;

  AuthDataSourceImpl(this._ref) {
    auth = _ref.read(firebaseAuthProvider);
    firebaseApi = _ref.read(firebaseApiProvider);
    firestore = _ref.read(firestoreProvider);
  }

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
  Future<UserCredential> patientLogin(UserCred user) async {
    return await auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  /// signup with email and password
  @override
  Future<UserCredential> signUpWithEmailAndPassword(NewUser user) async {
    return await auth.createUserWithEmailAndPassword(
        email: user.emailAddress, password: user.password);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserCredential> doctorSignUp(NewDoctor doctor) async {
    return await auth.createUserWithEmailAndPassword(
        email: doctor.emailAddress, password: doctor.password);
  }

  @override
  Future<UserCredential> doctorLogin(UserCred user) async {
    return await auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  @override
  Future<bool> updateFcmToken(
      {required String fcmToken,
      required String email,
      required String userType}) async {
    bool updated = false;
    late DocumentReference docRef;
    if (userType == 'patient') {
      docRef = firestore.collection('patients').doc(email);
    } else {
      docRef = firestore.collection('doctors').doc(email);
    }
    await docRef.update({'fcmToken': fcmToken}).then((_) {
      updated = true;
    });
    return updated;
  }
}
