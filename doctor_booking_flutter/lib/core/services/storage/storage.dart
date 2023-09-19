import 'dart:convert';

import 'package:doctor_booking_flutter/app/common/auth/data/models/user.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/patient/auth/data/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_keys.dart';

late SharedPreferences prefs;

class Storage {
  Storage();

  //save and fetch patient info
  void savePatientInfo(Patient patient) {
    prefs.setString(kUserKey, json.encode(patient.toJson()));
    prefs.setString(kUserTypeKey, 'patient');
  }

  Patient? fetchPatientInfo() => prefs.containsKey(kUserKey)
      ? Patient.fromJson(json.decode(prefs.getString(kUserKey)!))
      : null;

  //save and fetch doctor info
  void saveDoctorInfo(Doctor doctor) {
    prefs.setString(kUserKey, json.encode(doctor.toJson()));
    prefs.setString(kUserTypeKey, 'doctor');
  }

  Doctor? fetchDoctorInfo() => prefs.containsKey(kUserKey)
      ? Doctor.fromJson(json.decode(prefs.getString(kUserKey)!))
      : null;

  String? fetchUserType() =>
      prefs.containsKey(kUserTypeKey) ? prefs.getString(kUserTypeKey)! : null;

  //save and fetch themeMode
  void saveThemeMode(ThemeMode theme) => prefs.setInt(
      kThemeModeKey,
      theme == ThemeMode.light
          ? 0
          : theme == ThemeMode.dark
              ? 1
              : 2);

  ThemeMode fetchThemeMode() => prefs.containsKey(kThemeModeKey)
      ? (prefs.getInt(kThemeModeKey)! == 0
          ? ThemeMode.light
          : prefs.getInt(kThemeModeKey) == 1
              ? ThemeMode.dark
              : ThemeMode.system)
      : ThemeMode.system;

  //save and fetch hide balance option
  void saveHideBalance(bool value) => prefs.setBool(kHideBalanceKey, value);

  bool fetchHideBalance() => prefs.containsKey(kHideBalanceKey)
      ? prefs.getBool(kHideBalanceKey)!
      : false;

  //save and fetch selected avatar
  void saveSelectedAvatar(int value) => prefs.setInt(kSelectedAvatarKey, value);

  int fetchSelectedAvatar() => prefs.containsKey(kSelectedAvatarKey)
      ? prefs.getInt(kSelectedAvatarKey)!
      : 0;

  void saveOnBoardingInfo() => prefs.setBool(kOnBoardingKey, true);

  bool fetchOnBoardingInfo() => prefs.containsKey(kOnBoardingKey);

  void removeUser() {
    String? userType = fetchUserType();
    if (userType != null) {
      prefs.remove(userType == 'patient' ? kUserKey : kDoctorKey);
    }
  }

  void removeAll() => prefs.clear();
}
