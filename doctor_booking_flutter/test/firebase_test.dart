import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:doctor_booking_flutter/core/api/firebase.dart';

import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_doctor.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_user.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:doctor_booking_flutter/app/patient/auth/data/models/patient.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/patient/home/data/data_source/appointment_datasource_impl.dart';


bool isSameAppointments(Appointment a, Appointment b){
  bool isIdentical = true;
  isIdentical = isIdentical &&(a.valid == b.valid);
  if (a.bookingStart != null && b.bookingStart!= null) {
    isIdentical = isIdentical && (a.bookingStart!.isAtSameMomentAs(b.bookingStart!));
  }
  if (a.bookingEnd != null && b.bookingEnd!= null) {
    isIdentical = isIdentical && (a.bookingEnd!.isAtSameMomentAs(b.bookingEnd!));
  }
  isIdentical = isIdentical &&(a.doctorId == b.doctorId);
  isIdentical = isIdentical &&(a.patientId == b.patientId);
  return isIdentical;
}


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
        final retrievedDoctor = await firebaseApi.getDoctorData(email);

        expect(retrievedDoctor.speciality, doctor.speciality);
        expect(retrievedDoctor.emailAddress, doctor.emailAddress);
        expect(retrievedDoctor.fullName, doctor.fullName);
        expect(retrievedDoctor.userId, doctor.userId);
      });
    });

    group("AppointmentTest", () {
      test("Check Appointment Insert Single Patient & Doctor",  () async {
        final instance = FakeFirebaseFirestore();
        final auth = MockFirebaseAuth();
        FirebaseApi firebaseApi = FirebaseApi(instance);

        final AppointmentDataSourceImpl appointmentDS = AppointmentDataSourceImpl(instance, firebaseApi);

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
        final appointment = Appointment(bookingStart: appointmentStart, bookingEnd: appointmentEnd, patientId: patient.userId, doctorId: doctor.userId, userEmail: patient.emailAddress, patientNote: "assessment of visual acuity", doctorName: doctor.fullName, doctorSpeciality: doctor.speciality);
        // Note: Unclear Reference "userEmail" for appointment (doctor or patient?)

        // unclear whether any other value can be returned => Todo: test for error
        final returnV = await appointmentDS.bookDoctorAppointment(newAppointment: appointment, doctor: doctor, patientEmail: patient.emailAddress);

        expect(returnV, true);
      });



      test("Check Appointment Correctly Added - Single Doctor & patient",  () async {
        final instance = FakeFirebaseFirestore();
        final auth = MockFirebaseAuth();
        FirebaseApi firebaseApi = FirebaseApi(instance);

        final AppointmentDataSourceImpl appointmentDS = AppointmentDataSourceImpl(instance, firebaseApi);

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
        final appointment = Appointment(bookingStart: appointmentStart, bookingEnd: appointmentEnd, patientId: patient.userId, doctorId: doctor.userId, userEmail: patient.emailAddress, patientNote: "assessment of visual acuity", doctorName: doctor.fullName, doctorSpeciality: doctor.speciality);
        // Note: Unclear Reference "userEmail" for appointment (doctor or patient?)

        // unclear whether any other value can be returned => Todo: test for error
        await appointmentDS.bookDoctorAppointment(newAppointment: appointment, doctor: doctor, patientEmail: patient.emailAddress);
        bool valid = true;
        final patientAppointments =(await firebaseApi.getPatientData(patientMail)).appointments;
        final doctorAppointments =(await firebaseApi.getDoctorData(doctorMail)).appointments;
        // appointment might profit from a unique id.
        //print(patientAppointments.map((e) => e.hashCode).first)
        valid = valid && patientAppointments.map((e) => isSameAppointments(e,appointment)).contains(true);
        valid = valid && doctorAppointments.map((e) => isSameAppointments(e,appointment)).contains(true);
        expect(valid, true);
      });


      test("Check Appointment Correctly Added - Single Doctor & Multiple patients - No Doctor reloading",  () async {
        final instance = FakeFirebaseFirestore();
        final auth = MockFirebaseAuth();
        FirebaseApi firebaseApi = FirebaseApi(instance);

        final AppointmentDataSourceImpl appointmentDS = AppointmentDataSourceImpl(instance, firebaseApi);

        // Insert Doctor
        const doctorMail = "doctor1@bth.se";
        final doctorUser = NewDoctor(fullName: "Jane Doe, M.D.", emailAddress: doctorMail, password: "password", speciality: "Optometrist");
        final doctorCred = await auth.createUserWithEmailAndPassword(email: doctorUser.emailAddress, password: doctorUser.password);
        firebaseApi.storeDoctorData(newDoctor: doctorUser, credential: doctorCred);
        Doctor doctor = await firebaseApi.getDoctorData(doctorMail);

        List<String> mails = [];
        List<Appointment> appointments = [];
        var appointmentStart = DateTime.utc(2023, 10, 2, 12, 0, 0);
        for (int i=0; i<5; i++){
          String char = String.fromCharCode(i);
          String name = char*3;
          String patientMail = "$name@test.com";
          mails.add(patientMail);
          var user = NewUser(fullName: name, emailAddress: patientMail, password: name);
          final userCred = await auth.createUserWithEmailAndPassword(email: user.emailAddress, password: user.password);
          firebaseApi.storePatientData(newUser: user, credential: userCred);
          Patient patient = await firebaseApi.getPatientData(patientMail);
          // Insert Appointments

          final appointmentEnd = appointmentStart.add(const Duration(minutes: 30));
          appointmentStart = appointmentStart.add(const Duration(minutes: 30));

          final appointment = Appointment(bookingStart: appointmentStart, bookingEnd: appointmentEnd, patientId: patient.userId, doctorId: doctor.userId, userEmail: patient.emailAddress, patientNote: "assessment of visual acuity", doctorName: doctor.fullName, doctorSpeciality: doctor.speciality);
          appointments.add(appointment);
          // Note: Unclear Reference "userEmail" for appointment (doctor or patient?)
          await appointmentDS.bookDoctorAppointment(newAppointment: appointment, doctor: doctor, patientEmail: patient.emailAddress);
        }

        bool valid = true;
        final doctorAppointments =(await firebaseApi.getDoctorData(doctorMail)).appointments;
        for (int i=0; i<5;i++){
          final patientMail = mails.elementAt(i);
          final appointment = appointments.elementAt(i);
          bool check = valid;

          // appointment might profit from a unique id.
          final patientAppointments =(await firebaseApi.getPatientData(patientMail)).appointments;

          valid = valid && patientAppointments.map((e) => isSameAppointments(e,appointment)).contains(true);
          valid = valid && doctorAppointments.map((e) => isSameAppointments(e,appointment)).contains(true);
          if (valid != check) print("Mistake in $i");
        }
        // Will fail because Doctor is only generated once and update takes a fixed doctor for some reason
        // Fine for single service. May serve as race condition in actual application (hard to synchronize, while patient update works more quickly)
        expect(valid, true);
      });


      test("Check Appointment Correctly Added - Single Doctor & Multiple patients",  () async {
        final instance = FakeFirebaseFirestore();
        final auth = MockFirebaseAuth();
        FirebaseApi firebaseApi = FirebaseApi(instance);

        final AppointmentDataSourceImpl appointmentDS = AppointmentDataSourceImpl(instance, firebaseApi);

        // Insert Doctor
        const doctorMail = "doctor1@bth.se";
        final doctorUser = NewDoctor(fullName: "Jane Doe, M.D.", emailAddress: doctorMail, password: "password", speciality: "Optometrist");
        final doctorCred = await auth.createUserWithEmailAndPassword(email: doctorUser.emailAddress, password: doctorUser.password);
        firebaseApi.storeDoctorData(newDoctor: doctorUser, credential: doctorCred);
        Doctor doctor;

        List<String> mails = [];
        List<Appointment> appointments = [];
        var appointmentStart = DateTime.utc(2023, 10, 2, 12, 0, 0);
        for (int i=0; i<5; i++){
          doctor = await firebaseApi.getDoctorData(doctorMail);
          String char = String.fromCharCode(i);
          String name = char*3;
          String patientMail = "$name@test.com";
          mails.add(patientMail);
          var user = NewUser(fullName: name, emailAddress: patientMail, password: name);
          final userCred = await auth.createUserWithEmailAndPassword(email: user.emailAddress, password: user.password);
          firebaseApi.storePatientData(newUser: user, credential: userCred);
          Patient patient = await firebaseApi.getPatientData(patientMail);
          // Insert Appointments

          final appointmentEnd = appointmentStart.add(const Duration(minutes: 30));
          //appointmentStart = appointmentStart.add(const Duration(minutes: 30));

          final appointment = Appointment(bookingStart: appointmentStart, bookingEnd: appointmentEnd, patientId: patient.userId, doctorId: doctor.userId, userEmail: patient.emailAddress, patientNote: "assessment of visual acuity", doctorName: doctor.fullName, doctorSpeciality: doctor.speciality);
          appointments.add(appointment);
          // Note: Unclear Reference "userEmail" for appointment (doctor or patient?)
          await appointmentDS.bookDoctorAppointment(newAppointment: appointment, doctor: doctor, patientEmail: patient.emailAddress);
        }

        bool valid = true;
        final doctorAppointments =(await firebaseApi.getDoctorData(doctorMail)).appointments;
        for (int i=0; i<5;i++){
          final patientMail = mails.elementAt(i);
          final appointment = appointments.elementAt(i);
          bool check = valid;

          // appointment might profit from a unique id.
          final patientAppointments =(await firebaseApi.getPatientData(patientMail)).appointments;

          valid = valid && patientAppointments.map((e) => isSameAppointments(e,appointment)).contains(true);
          valid = valid && doctorAppointments.map((e) => isSameAppointments(e,appointment)).contains(true);
          if (valid != check) print("Mistake in $i");
        }
        // Note: The upload command does not prevent multiple bookings at the same time -> See booking_calendar/lib/src/core/booking_controller.dart
        expect(valid, true);
      });

      // Todo: Check double bookings (over booking controller, booking_calendar and more ....)
    });
  });
}