import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable(explicitToJson: true)
class Appointment extends Equatable {
  /// The generated code assumes these values exist in JSON.
  final String? patientId;
  final String? patientName;
  final String? doctorId;
  final String? userEmail;
  final String? patientNote;
  final bool? valid;
  final String? doctorName;
  final String? doctorSpeciality;

  bool get isActive => bookingEnd?.isBefore(DateTime.now()) ?? false;

  static DateTime timeStampToDateTime(Timestamp timestamp) {
    return DateTime.parse(timestamp.toDate().toString());
  }

  static Timestamp dateTimeToTimeStamp(DateTime? dateTime) {
    return Timestamp.fromDate(dateTime ?? DateTime.now());
  }

  @JsonKey(fromJson: timeStampToDateTime, toJson: dateTimeToTimeStamp)
  final DateTime? bookingStart;
  @JsonKey(fromJson: timeStampToDateTime, toJson: dateTimeToTimeStamp)
  final DateTime? bookingEnd;

  const Appointment(
      {this.bookingStart,
      this.bookingEnd,
      this.patientId,this.patientName,
      this.doctorId,
      this.userEmail,
      this.patientNote,
      this.doctorName,
      this.doctorSpeciality,
      this.valid = true});

  /// Connect the generated [_$SportBookingFromJson] function to the `fromJson`
  /// factory.
  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  /// Connect the generated [_$SportBookingToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);

  //convert appointment to DateTimerRange
  DateTimeRange get toDateTimeRange =>
      DateTimeRange(start: bookingStart!, end: bookingEnd!);



  @override
  // TODO: implement props
  List<Object?> get props => [
        bookingStart,
        bookingEnd,
        patientId,patientName,
        doctorId,
        userEmail,
        patientNote,
        doctorName,
        doctorSpeciality,
        valid
      ];
}
