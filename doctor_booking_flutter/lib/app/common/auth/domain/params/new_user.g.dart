// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUser _$NewUserFromJson(Map<String, dynamic> json) => NewUser(
      fullName: json['fullName'] as String,
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
      appointments: (json['appointments'] as List<dynamic>?)
              ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$NewUserToJson(NewUser instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'emailAddress': instance.emailAddress,
      'password': instance.password,
      'userId': instance.userId,
      'appointments': instance.appointments,
    };
