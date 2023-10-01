import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_doctor.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_user.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/patient/auth/data/models/patient.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final FirebaseFirestore firestore;
  late CollectionReference bookings;

   FirebaseApi(this.firestore) {
    bookings = firestore.collection('bookings');
  }

  ///add new patient details to patients collection
  Future<bool> storePatientData(
      {required NewUser newUser, required UserCredential credential}) async {
    newUser.userId = credential.user!.uid;
    await firestore
        .collection('patients')
        .doc(credential.user!.email)
        .set(newUser.toJson())
        .onError((error, stackTrace) => false);
    return true;
  }

  ///add new doctor details to doctors collection
  Future<bool> storeDoctorData(
      {required NewDoctor newDoctor,
      required UserCredential credential}) async {
    newDoctor.userId = credential.user!.uid;
    await firestore
        .collection('doctors')
        .doc(credential.user!.email)
        .set(newDoctor.toJson())
        .onError((error, stackTrace) => false);
    return true;
  }

  //check if user exist
  Future<bool> getPatient(String email) async {
    // bool exists = false;
    var doc = await firestore.collection('patients').doc(email).get();
    return doc.exists;
  }

  Future<Patient> getPatientData(String email) async {
    DocumentReference docRef = firestore.collection('patients').doc(email);
    return Patient.fromJson(await docRef
        .get()
        .then((value) => value.data()! as Map<String, dynamic>));
  }

  //check if doctor exists
  Future<bool> getDoctor(String email) async {
    bool exists = false;
    await firestore.collection('doctors').doc(email).get();
    return exists;
  }

  // Debugging function to get reliable access to DoctorId
  Future<Doctor> getDoctorData(String email) async {
    DocumentReference docRef = firestore.collection('doctors').doc(email);
    return Doctor.fromJson(await docRef
        .get()
        .then((value) => value.data()! as Map<String, dynamic>));
  }

  ///add new doctor details to doctors db



  ///This is how can you get the reference to your data from the collection, and serialize the data with the help of the Firestore [withConverter]. This function would be in your repository.
  CollectionReference<Appointment> getBookingStream({required String docId}) {
    return bookings
        .doc(docId)
        .collection('appointments')
        .withConverter<Appointment>(
          fromFirestore: (snapshots, _) =>
              Appointment.fromJson(snapshots.data()!),
          toFirestore: (snapshots, _) => snapshots.toJson(),
        );
  }

  ///How you actually get the stream of data from Firestore with the help of the previous function
  ///note that this query filters are for my data structure, you need to adjust it to your solution.
  Stream<dynamic>? getBookingStreamFirebase(
      {required DateTime end, required DateTime start}) {
    return getBookingStream(docId: 'YOUR_DOC_ID')
        .where('bookingStart', isGreaterThanOrEqualTo: start)
        .where('bookingStart', isLessThanOrEqualTo: end)
        .snapshots();
  }

  ///After you fetched the data from firestore, we only need to have a list of datetimes from the bookings:
  List<DateTimeRange> convertStreamResultFirebase(
      {required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///Note that this is dynamic, so you need to know what properties are available on your result, in our case the [SportBooking] has bookingStart and bookingEnd property
    List<DateTimeRange> converted = [];
    for (var i = 0; i < streamResult.size; i++) {
      final item = streamResult.docs[i].data();
      converted.add(
          DateTimeRange(start: (item.bookingStart!), end: (item.bookingEnd!)));
    }
    return converted;
  }

  ///This is how you upload data to Firestore
  Future<dynamic> uploadBookingFirebase(
      {required Appointment newAppointment}) async {
    await bookings
        .doc('your id, or autogenerate')
        .collection('bookings')
        .add(newAppointment.toJson())
        .then((value) => print("Booking Added"))
        .catchError((error) => print("Failed to add booking: $error"));
  }
}

/**AFTER YOU HAVE EVERY HELPER FUNCTION YOU CAN PASS THESE TO YOUR BOOKINGCALENDAR */

/*BookingCalendar(
bookingService: mockBookingService,
convertStreamResultToDateTimeRanges: convertStreamResultFirebase,
getBookingStream: getBookingStreamFirebase,
uploadBooking: uploadBookingFirebase,
uploadingWidget: const CircularProgressIndicator(),
//... other customisation properties
);
}*/
