import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

late final Provider<FirebaseAuth> firebaseAuthProvider;
late final Provider<FirebaseApp> firebaseAppProvider;