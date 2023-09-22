import 'package:doctor_booking_flutter/app/common/auth/data/models/user.dart';
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

  List<DateTimeRange> get scheduleRangeList =>
      appointments.map((e) => e.toDateTimeRange).toList();

  Doctor(
      {required this.fullName,
      required this.emailAddress,
      this.appointments = const [],
      required this.speciality,
      this.isApproved = false,
      this.userId});

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
