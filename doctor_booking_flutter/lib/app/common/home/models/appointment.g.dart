// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingService _$BookingServiceFromJson(Map<String, dynamic> json) =>
    BookingService(
      bookingStart:
          BookingService.timeStampToDateTime(json['bookingStart'] as Timestamp),
      bookingEnd:
          BookingService.timeStampToDateTime(json['bookingEnd'] as Timestamp),
      patientId: json['patientId'] as String?,
      doctorId: json['doctorId'] as String?,
      userEmail: json['userEmail'] as String?,
      serviceDuration: json['serviceDuration'] as int?,
      servicePrice: json['servicePrice'] as int?,
    );

Map<String, dynamic> _$BookingServiceToJson(BookingService instance) =>
    <String, dynamic>{
      'patientId': instance.patientId,
      'doctorId': instance.doctorId,
      'userEmail': instance.userEmail,
      'serviceDuration': instance.serviceDuration,
      'servicePrice': instance.servicePrice,
      'bookingStart': BookingService.dateTimeToTimeStamp(instance.bookingStart),
      'bookingEnd': BookingService.dateTimeToTimeStamp(instance.bookingEnd),
    };
