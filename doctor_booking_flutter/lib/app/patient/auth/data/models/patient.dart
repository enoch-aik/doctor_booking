import 'package:doctor_booking_flutter/app/common/auth/data/models/user.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable(explicitToJson: true)
class Patient {
  final String fullName;
  final String emailAddress;
  String? userId;
  final List<Appointment> appointments;
  final String? fcmToken;

  Patient(
      {required this.fullName,
      required this.emailAddress,
      this.appointments = const [],this.fcmToken,
      this.userId});

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);

  List<Appointment> get upcomingAppointments => appointments
      .where((element) => element.bookingStart!.isAfter(DateTime.now()))
      .toList();
}
