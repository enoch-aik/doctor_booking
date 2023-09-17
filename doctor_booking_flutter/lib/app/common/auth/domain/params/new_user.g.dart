// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUser _$NewUserFromJson(Map<String, dynamic> json) => NewUser(
      fullName: json['fullName'] as String,
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
      schedules: (json['schedules'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$NewUserToJson(NewUser instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'emailAddress': instance.emailAddress,
      'password': instance.password,
      'userId': instance.userId,
      'schedules': instance.schedules.map((e) => e.toIso8601String()).toList(),
    };
