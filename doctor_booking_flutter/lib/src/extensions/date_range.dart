import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeRangeExtension on DateTimeRange {
  String formatBookingDateTime() {
    final DateFormat dayOfWeekFormat = DateFormat.E('en_US');
    final DateFormat monthDayFormat = DateFormat.MMMd('en_US');
    final DateFormat timeFormat = DateFormat('HH:mm', 'en_US');

    final String startDayOfWeek = dayOfWeekFormat.format(start);
    final String startMonthDay = monthDayFormat.format(start);
    final String startTime = timeFormat.format(start);
    final String endTime = timeFormat.format(end);

    return '$startDayOfWeek, $startMonthDay, $startTime - $endTime';
  }

  String formatToInfoDateTime() {
    final DateFormat dayOfWeekFormat = DateFormat.E('en_US');
    final DateFormat monthDayFormat = DateFormat.MMMd('en_US');
    final DateFormat timeFormat = DateFormat('HH:mm', 'en_US');

    final String startDayOfWeek = dayOfWeekFormat.format(start);
    final String startMonthDay = monthDayFormat.format(start);
    final String startTime = timeFormat.format(start);
    final String endTime = timeFormat.format(end);

    return 'on $startDayOfWeek, $startMonthDay from $startTime - $endTime';
  }

  //get if am appointment is still ongoing
  bool get isOngoing =>
      DateTime.now().isAfter(start) && DateTime.now().isBefore(end);

  //get if this appointment is in the past
  bool get isPast => DateTime.now().isAfter(end);

  bool get isLessThan24HrsToAppointment =>
      start.difference(DateTime.now()) < const Duration(hours: 24);
}
