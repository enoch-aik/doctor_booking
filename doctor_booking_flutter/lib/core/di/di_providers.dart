import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_flutter/core/api/firebase.dart';
import 'package:doctor_booking_flutter/core/services/storage/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<FirebaseAuth> firebaseAuthProvider =
    Provider((ref) => FirebaseAuth.instance);
final Provider<FirebaseApp?> firebaseAppProvider =
    Provider<FirebaseApp?>((ref) => null);
final Provider<FirebaseFirestore> firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

//provider for firebase api
final Provider<FirebaseApi> firebaseApiProvider =
    Provider((ref) => FirebaseApi(ref.watch(firestoreProvider)));

//This boolean is used to get there is a current user, this is true if there is a current user and false if there is no current user
final isLoggedIn = StateProvider<bool>((ref) {
  return ref.watch(firebaseAuthProvider).currentUser != null;
});

//storage provider
//storage providers
final storeProvider = Provider(
  (ref) {
    return Storage();
  },
);
