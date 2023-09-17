import 'package:doctor_booking_flutter/app/common/auth/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient  {
  final String fullName;
  final String emailAddress;
  String? userId;
  final List<DateTime> schedules;

  Patient(
      {required this.fullName,
      required this.emailAddress,
      this.schedules = const [],
      this.userId});

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
