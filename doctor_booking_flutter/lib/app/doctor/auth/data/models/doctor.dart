import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable(explicitToJson: true)
class Doctor {
  final String fullName;
  final String emailAddress;
  String? userId;
  final String speciality;
  final List<Appointment> appointments;
  final bool isApproved;
  final String? fcmToken;

  List<DateTimeRange> get scheduleRangeList =>
      appointments.map((e) => e.toDateTimeRange).toList();

  List<Appointment> get upcomingAppointments => appointments
      .where((element) => element.bookingStart!.isAfter(DateTime.now()))
      .toList();

  //check if a userId has booked an upcoming appointment

  bool hasPatientBookedPreviously(String patientId) {
    return upcomingAppointments.any((element) => element.patientId == patientId);
  }

  Doctor(
      {required this.fullName,
      required this.emailAddress,
      this.appointments = const [],
      required this.speciality,
      this.isApproved = false,this.fcmToken,
      this.userId});

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
