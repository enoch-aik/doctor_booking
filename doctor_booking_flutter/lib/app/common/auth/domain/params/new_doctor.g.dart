// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewDoctor _$NewDoctorFromJson(Map<String, dynamic> json) => NewDoctor(
      fullName: json['fullName'] as String,
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
      schedules: (json['schedules'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      isApproved: json['isApproved'] as bool? ?? false,
      speciality: json['speciality'] as String,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$NewDoctorToJson(NewDoctor instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'emailAddress': instance.emailAddress,
      'password': instance.password,
      'userId': instance.userId,
      'speciality': instance.speciality,
      'isApproved': instance.isApproved,
      'schedules': instance.schedules.map((e) => e.toIso8601String()).toList(),
    };
