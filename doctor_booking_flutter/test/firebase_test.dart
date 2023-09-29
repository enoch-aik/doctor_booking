import 'package:doctor_booking_flutter/app/common/auth/domain/params/user_credentials.dart';
import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:doctor_booking_flutter/core/api/firebase.dart';

import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_doctor.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_user.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:doctor_booking_flutter/app/patient/auth/data/models/patient.dart';


void main() {
  group('UserData', ()
  {
    test("Check Patient Mail for empty database", () async {
      String email = "patient7799123@bth.se";
      final instance = FakeFirebaseFirestore();

      FirebaseApi firebaseApi = FirebaseApi(instance);

      bool result = await firebaseApi.getPatient(email);
      expect(result, false);
    });

    test("Check Patient Mail for non-empty database", () async {
      String email = "patient7799123@bth.se";
      final instance = FakeFirebaseFirestore();

      final mock_data = <String, String>{
        "name": "John",
        "surname" : "Doe"
      };
      await instance.collection('patients').doc("patient1@bth.se").set(mock_data);

      FirebaseApi firebaseApi = FirebaseApi(instance);

      bool result = await firebaseApi.getPatient(email);
      expect(result, false);
    });

    test("Check Patient Mail after adding",  () async {
      String email = "patient1@bth.se";
      final instance = FakeFirebaseFirestore();

      final mock_data = <String, String>{
        "name": "John",
        "surname" : "Doe"
      };
      await instance.collection('patients').doc(email).set(mock_data);

      FirebaseApi firebaseApi = FirebaseApi(instance);

      bool result = await firebaseApi.getPatient(email);
      // print(instance.dump());

      expect(result, true);
    });

    test("Check Patient Data Insert",  () async {
      String email = "patient1@bth.se";
      final instance = FakeFirebaseFirestore();
      final auth = MockFirebaseAuth();

      final user = NewUser(fullName: "John Doe", emailAddress: email, password: "password");


      final userCred = await auth.createUserWithEmailAndPassword(email: user.emailAddress, password: user.password);

      FirebaseApi firebaseApi = FirebaseApi(instance);

      firebaseApi.storePatientData(newUser: user, credential: userCred);

      bool result = await firebaseApi.getPatient(email);


      expect(result, true);
    });

    test("Check Patient Data Retrieval after Insert",  () async {
      String email = "patient1@bth.se";
      final instance = FakeFirebaseFirestore();
      final auth = MockFirebaseAuth();

      final user = NewUser(fullName: "John Doe", emailAddress: email, password: "password");


      final userCred = await auth.createUserWithEmailAndPassword(email: user.emailAddress, password: user.password);

      FirebaseApi firebaseApi = FirebaseApi(instance);

      firebaseApi.storePatientData(newUser: user, credential: userCred);

      Patient result = await firebaseApi.getPatientData(email);
      Patient original = user.toPatient();

      expect(result.emailAddress, original.emailAddress);
      expect(result.appointments, original.appointments);
      expect(result.fullName, original.fullName);
    });
  });
}
