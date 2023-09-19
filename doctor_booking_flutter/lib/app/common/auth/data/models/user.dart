abstract class AppUser {
  final String fullName;
  final String emailAddress;
  String? userId;
  final List<DateTime> schedules;
  final String? speciality;

  AppUser(
      {required this.fullName,
      required this.emailAddress,
      required this.schedules,
      this.userId,
      this.speciality});
}
