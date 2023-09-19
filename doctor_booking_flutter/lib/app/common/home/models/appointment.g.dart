// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      bookingStart:
          Appointment.timeStampToDateTime(json['bookingStart'] as Timestamp),
      bookingEnd:
          Appointment.timeStampToDateTime(json['bookingEnd'] as Timestamp),
      patientId: json['patientId'] as String?,
      doctorId: json['doctorId'] as String?,
      userEmail: json['userEmail'] as String?,
      serviceDuration: json['serviceDuration'] as int?,
      servicePrice: json['servicePrice'] as int?,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'patientId': instance.patientId,
      'doctorId': instance.doctorId,
      'userEmail': instance.userEmail,
      'serviceDuration': instance.serviceDuration,
      'servicePrice': instance.servicePrice,
      'bookingStart': Appointment.dateTimeToTimeStamp(instance.bookingStart),
      'bookingEnd': Appointment.dateTimeToTimeStamp(instance.bookingEnd),
    };
