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
}
