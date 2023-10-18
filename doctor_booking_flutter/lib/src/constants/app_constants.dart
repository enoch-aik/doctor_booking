import 'package:doctor_booking_flutter/src/widgets/bottom_nav_icons.dart';
import 'package:flutter/widgets.dart';

const List<BottomNavigationBarItem> patientAppNavItems = [
  BottomNavigationBarItem(
    icon: Icon(BottomNavIcons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(BottomNavIcons.search),
    label: 'Search',
  ),
  BottomNavigationBarItem(
    icon: Icon(BottomNavIcons.calendar),
    label: 'Calendar',
  ),
  BottomNavigationBarItem(
    icon: Icon(BottomNavIcons.profile),
    label: 'Profile',
  ),
];

const List<BottomNavigationBarItem> doctorAppNavItems = [
  BottomNavigationBarItem(
    icon: Icon(BottomNavIcons.home),
    label: 'Home',
  ),
  /*BottomNavigationBarItem(
    icon: Icon(BottomNavIcons.calendar),
    label: 'Calendar',
  ),*/
  BottomNavigationBarItem(
    icon: Icon(BottomNavIcons.profile),
    label: 'Profile',
  ),
];
