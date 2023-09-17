import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_doctor.g.dart';

@JsonSerializable()
class NewDoctor {
  final String fullName;
  final String emailAddress;
  final String password;
  String? userId;
  final String speciality;
  final bool isApproved;
  final List<DateTime> schedules;

  NewDoctor(
      {required this.fullName,
        required this.emailAddress,
        required this.password,
        this.schedules = const [],this.isApproved = false,required this.speciality,
        this.userId});

  factory NewDoctor.fromJson(Map<String, dynamic> json) =>
      _$NewDoctorFromJson(json);

  Map<String, dynamic> toJson() => _$NewDoctorToJson(this);

  Doctor toDoctor() => Doctor(
      fullName: fullName,
      emailAddress: emailAddress,
      userId: userId,
      schedules: schedules, speciality: speciality);
}
