// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      fullName: json['fullName'] as String,
      emailAddress: json['emailAddress'] as String,
      schedules: (json['schedules'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      speciality: json['speciality'] as String,
      isApproved: json['isApproved'] as bool? ?? false,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'emailAddress': instance.emailAddress,
      'userId': instance.userId,
      'speciality': instance.speciality,
      'schedules': instance.schedules.map((e) => e.toIso8601String()).toList(),
      'isApproved': instance.isApproved,
    };
