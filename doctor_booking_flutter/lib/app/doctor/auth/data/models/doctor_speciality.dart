class DoctorSpeciality {
  final String title;
  final String icon;

  DoctorSpeciality({required this.title, required this.icon});

  static List<DoctorSpeciality> specialities = [
    DoctorSpeciality(title: 'Chiropractor', icon: '🩻'),
    DoctorSpeciality(title: 'Dentist', icon: '🦷'),
    DoctorSpeciality(title: 'Gerontologist', icon: '👴'),
    DoctorSpeciality(title: 'Nutritionist', icon: '🍇'),
    DoctorSpeciality(title: 'Optometrist', icon: '👁️'),
    DoctorSpeciality(title: 'Pathologist', icon: '🦠'),
    DoctorSpeciality(title: 'Pharmacist', icon: '💊'),
    // DoctorSpeciality(title: 'Psychiatrist', icon: ''),
    // DoctorSpeciality(title: 'Psychologist', icon: ''),
    DoctorSpeciality(title: 'Therapist', icon: '🧘‍♂️'),
  ];

  static DoctorSpeciality getFromSpeciality(String speciality) {
    return specialities.firstWhere((element) => element.title == speciality);
  }

  static String getIconFromSpeciality(String speciality) {
    return specialities
        .firstWhere((element) => element.title == speciality)
        .icon;
  }
}
