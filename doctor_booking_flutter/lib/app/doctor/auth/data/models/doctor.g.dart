// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      fullName: json['fullName'] as String,
      emailAddress: json['emailAddress'] as String,
      appointments: (json['appointments'] as List<dynamic>?)
              ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      speciality: json['speciality'] as String,
      isApproved: json['isApproved'] as bool? ?? false,
      fcmToken: json['fcmToken'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'emailAddress': instance.emailAddress,
      'userId': instance.userId,
      'speciality': instance.speciality,
      'appointments': instance.appointments.map((e) => e.toJson()).toList(),
      'isApproved': instance.isApproved,
      'fcmToken': instance.fcmToken,
    };
