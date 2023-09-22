import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/patient/auth/data/models/patient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_user.g.dart';

@JsonSerializable()
class NewUser {
  final String fullName;
  final String emailAddress;
  final String password;
  String? userId;
  final List<Appointment> appointments;

  NewUser(
      {required this.fullName,
      required this.emailAddress,
      required this.password,
      this.appointments = const [],
      this.userId});

  factory NewUser.fromJson(Map<String, dynamic> json) =>
      _$NewUserFromJson(json);

  Map<String, dynamic> toJson() => _$NewUserToJson(this);

  Patient toPatient() => Patient(
      fullName: fullName,
      emailAddress: emailAddress,
      userId: userId,
      appointments: appointments);
}
