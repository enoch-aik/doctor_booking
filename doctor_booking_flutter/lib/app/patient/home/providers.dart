import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor_speciality.dart';
import 'package:doctor_booking_flutter/lib.dart';

final selectedHomeIndex = StateProvider<int>((ref) => 0);

final selectedDoctorSpeciality =
    StateProvider<DoctorSpeciality?>((ref) => null);
