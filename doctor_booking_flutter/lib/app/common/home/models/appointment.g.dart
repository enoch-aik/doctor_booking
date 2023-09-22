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
      patientNote: json['patientNote'] as String?,
      valid: json['valid'] as bool? ?? true,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'patientId': instance.patientId,
      'doctorId': instance.doctorId,
      'userEmail': instance.userEmail,
      'patientNote': instance.patientNote,
      'valid': instance.valid,
      'bookingStart': Appointment.dateTimeToTimeStamp(instance.bookingStart),
      'bookingEnd': Appointment.dateTimeToTimeStamp(instance.bookingEnd),
    };
