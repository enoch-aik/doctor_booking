import 'package:doctor_booking_flutter/app/common/auth/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  final String fullName;
  final String emailAddress;
  String? userId;
  final String speciality;
  final List<DateTime> schedules;
  final bool isApproved;

  Doctor(
      {required this.fullName,
        required this.emailAddress,
        this.schedules = const [],
        required this.speciality,this.isApproved = false,
        this.userId});

  factory Doctor.fromJson(Map<String, dynamic> json) =>
      _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
