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
      patientName: json['patientName'] as String?,
      doctorEmail: json['doctorEmail'] as String?,
      patientEmail: json['patientEmail'] as String?,
      doctorId: json['doctorId'] as String?,
      userEmail: json['userEmail'] as String?,
      patientNote: json['patientNote'] as String?,
      doctorName: json['doctorName'] as String?,
      doctorSpeciality: json['doctorSpeciality'] as String?,
      valid: json['valid'] as bool? ?? true,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) {
  final val = <String, dynamic>{
    'patientId': instance.patientId,
    'patientName': instance.patientName,
    'doctorId': instance.doctorId,
    'userEmail': instance.userEmail,
    'patientNote': instance.patientNote,
    'valid': instance.valid,
    'doctorName': instance.doctorName,
    'doctorSpeciality': instance.doctorSpeciality,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('doctorEmail', instance.doctorEmail);
  writeNotNull('patientEmail', instance.patientEmail);
  val['bookingStart'] = Appointment.dateTimeToTimeStamp(instance.bookingStart);
  val['bookingEnd'] = Appointment.dateTimeToTimeStamp(instance.bookingEnd);
  return val;
}
