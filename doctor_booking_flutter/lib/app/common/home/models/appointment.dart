import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingService {
  /// The generated code assumes these values exist in JSON.
  final String? patientId;
  final String? doctorId;
  final String? userEmail;
  final int? serviceDuration;
  final int? servicePrice;

  //Because we are storing timestamp in Firestore, we need a converter for DateTime
  static DateTime timeStampToDateTime(Timestamp timestamp) {
    return DateTime.parse(timestamp.toDate().toString());
  }

  static Timestamp dateTimeToTimeStamp(DateTime? dateTime) {
    return Timestamp.fromDate(dateTime ?? DateTime.now()); //To TimeStamp
  }

  @JsonKey(fromJson: timeStampToDateTime, toJson: dateTimeToTimeStamp)
  final DateTime? bookingStart;
  @JsonKey(fromJson: timeStampToDateTime, toJson: dateTimeToTimeStamp)
  final DateTime? bookingEnd;

  BookingService(
      {
      this.bookingStart,
      this.bookingEnd,
      this.patientId,
      this.doctorId,
      this.userEmail,
      this.serviceDuration,
      this.servicePrice});

  /// Connect the generated [_$SportBookingFromJson] function to the `fromJson`
  /// factory.
  factory BookingService.fromJson(Map<String, dynamic> json) =>
      _$BookingServiceFromJson(json);

  /// Connect the generated [_$SportBookingToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BookingServiceToJson(this);
}
