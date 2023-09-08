import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

 final Provider<FirebaseAuth> firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
 final Provider<FirebaseApp?> firebaseAppProvider = Provider<FirebaseApp?>((ref) => null);