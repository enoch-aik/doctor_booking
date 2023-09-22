// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewDoctor _$NewDoctorFromJson(Map<String, dynamic> json) => NewDoctor(
      fullName: json['fullName'] as String,
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
      appointments: (json['appointments'] as List<dynamic>?)
              ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
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
      'appointments': instance.appointments,
    };
