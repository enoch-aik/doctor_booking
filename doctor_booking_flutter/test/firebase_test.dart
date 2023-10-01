import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:doctor_booking_flutter/core/api/firebase.dart';

import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_doctor.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_user.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:doctor_booking_flutter/app/patient/auth/data/models/patient.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';


void main() {
  group('UserData', ()
  {
    group("PatientData", () {
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

        print(result.userId);

        expect(result.emailAddress, original.emailAddress);
        expect(result.appointments, original.appointments);
        expect(result.fullName, original.fullName);
      });
    });

    group("DoctorData", () {
      test("Check Doctor Mail for empty database", () async {
        String email = "doctor21390131@bth.se";
        final instance = FakeFirebaseFirestore();

        FirebaseApi firebaseApi = FirebaseApi(instance);

        bool result = await firebaseApi.getDoctor(email);
        expect(result, false);
      });

      test("Check Doctor Mail for non-empty database", () async {
        String email = "doctor21390131@bth.se";
        final instance = FakeFirebaseFirestore();

        final mock_data = <String, String>{
          "name": "Jane",
          "surname" : "Doe, M.D."
        };
        await instance.collection('doctors').doc("doctor1@bth.se").set(mock_data);

        FirebaseApi firebaseApi = FirebaseApi(instance);

        bool result = await firebaseApi.getDoctor(email);
        expect(result, false);
      });

      test("Check if Doctor exists after adding by email address", () async {
        String email = "doctor1@bth.se";
        final instance = FakeFirebaseFirestore();

        final mock_data = <String, String>{
          "name": "Jane",
          "surname" : "Doe, M.D."
        };

        await instance.collection('doctors').doc(email).set(mock_data);

        FirebaseApi firebaseApi = FirebaseApi(instance);

        bool result = await firebaseApi.getDoctor(email);
        print(instance.dump());

        expect(result, true);
      });

      test("Check Doctor Data Insert",  () async {
        final instance = FakeFirebaseFirestore();
        final auth = MockFirebaseAuth();

        String email = "doctor1@bth.se";
        final doctor = NewDoctor(fullName: "Jane Doe, M.D.", emailAddress: email, password: "password", speciality: "Optometrist");
        final doctorCred = await auth.createUserWithEmailAndPassword(email: doctor.emailAddress, password: doctor.password);

        FirebaseApi firebaseApi = FirebaseApi(instance);

        firebaseApi.storeDoctorData(newDoctor: doctor, credential: doctorCred);
        bool result = await firebaseApi.getDoctor(email);

        expect(result, true);
      });
    });

    group("AppointmentTest", () {
      test("Check Appointment Insert Single Patient & Doctor",  () async {
        final instance = FakeFirebaseFirestore();
        final auth = MockFirebaseAuth();
        FirebaseApi firebaseApi = FirebaseApi(instance);

        // Insert Doctor
        const doctorMail = "doctor1@bth.se";
        final doctorUser = NewDoctor(fullName: "Jane Doe, M.D.", emailAddress: doctorMail, password: "password", speciality: "Optometrist");
        final doctorCred = await auth.createUserWithEmailAndPassword(email: doctorUser.emailAddress, password: doctorUser.password);
        firebaseApi.storeDoctorData(newDoctor: doctorUser, credential: doctorCred);
        Doctor doctor = await firebaseApi.getDoctorData(doctorMail);

        // Insert Patient
        const patientMail = "patient1@bth.se";
        final patientUser = NewUser(fullName: "John Doe", emailAddress: patientMail, password: "password");
        final patientCred = await auth.createUserWithEmailAndPassword(email: patientUser.emailAddress, password: patientUser.password);
        firebaseApi.storePatientData(newUser: patientUser, credential: patientCred);
        Patient patient = await firebaseApi.getPatientData(patientMail);

        // Insert Appointments
        final appointmentStart = DateTime.utc(2023, 10, 2, 12, 0, 0);
        final appointmentEnd = appointmentStart.add(const Duration(minutes: 30));
        final appointment = Appointment(bookingStart: appointmentStart, bookingEnd: appointmentEnd, patientId: patient.userId, doctorId: doctor.userId, userEmail: patient.emailAddress, patientNote: "assessment of visual acuity");
        // Note: Unclear Reference "userEmail" for appointment (doctor or patient?)
        final key = await firebaseApi.uploadBookingFirebase(newAppointment: appointment);
        // Need something as return value (some id)

        // todo: check whether successful
        expect(key != null, true);
      });

      test("Check Doctor Data Insert",  () async {
        final instance = FakeFirebaseFirestore();
        final auth = MockFirebaseAuth();
        FirebaseApi firebaseApi = FirebaseApi(instance);

        // Insert Doctor
        String email = "doctor1@bth.se";
        final doctor = NewDoctor(fullName: "Jane Doe, M.D.", emailAddress: email, password: "password", speciality: "Optometrist");
        final doctorCred = await auth.createUserWithEmailAndPassword(email: doctor.emailAddress, password: doctor.password);
        firebaseApi.storeDoctorData(newDoctor: doctor, credential: doctorCred);

        // Insert Multiple Users
        for (int i=0; i<5; i++){
          String char = String.fromCharCode(i);
          String name = char*3;
          String mail = "$name@test.com";
          var user = NewUser(fullName: name, emailAddress: mail, password: name);
          final userCred = await auth.createUserWithEmailAndPassword(email: user.emailAddress, password: user.password);
          firebaseApi.storePatientData(newUser: user, credential: userCred);
        }

        // Insert Appointments
        // Todo: After appointment functionality is given

        expect(false, true);
      });
    });
  });
}