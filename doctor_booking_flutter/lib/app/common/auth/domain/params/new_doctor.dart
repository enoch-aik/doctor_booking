import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
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
  final List<Appointment> appointments;
  final String? fcmToken;

  NewDoctor(
      {required this.fullName,
        required this.emailAddress,
        required this.password,
        this.appointments = const [],this.isApproved = false,required this.speciality,this.fcmToken,
        this.userId});

  factory NewDoctor.fromJson(Map<String, dynamic> json) =>
      _$NewDoctorFromJson(json);

  Map<String, dynamic> toJson() => _$NewDoctorToJson(this);

  Doctor toDoctor() => Doctor(
      fullName: fullName,
      emailAddress: emailAddress,
      userId: userId,fcmToken: fcmToken,
      appointments: [], speciality: speciality);
}
