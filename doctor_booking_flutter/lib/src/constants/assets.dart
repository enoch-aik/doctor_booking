import 'dart:math';

class AppAssets {
  const AppAssets._();


  ///IMAGES
  static const String onboarding1 = 'assets/images/doctor_pose_1.png';
  static const String onboarding2 = 'assets/images/doctor_pose_2.png';
  static const String onboarding3 = 'assets/images/doctor_pose_3.png';
  static const String onboarding4 = 'assets/images/doctor_pose_4.png';

  ///SVG
  static const String googleIcon = 'assets/svg/google.svg';
  static const String acIcon = 'assets/svg/ac.svg';
  static const String dcIcon = 'assets/svg/dc.svg';
  static const String emptySvg = 'assets/svg/empty.svg';

  static String getAvatarImg(int index) {
    const String avatarDir = 'assets/images/avatars';
    if (index == 0 || index > 116) {
      return '$avatarDir/Number=1.png';
    }
    return '$avatarDir/Number=$index.png';
  }

static String getRandomAvatar (){
  return  getAvatarImg(Random().nextInt(116));

}
}

