import 'package:auto_route/annotations.dart';
import 'package:doctor_booking_flutter/app/common/auth/providers.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/patient/home/providers.dart';
import 'package:doctor_booking_flutter/core/di/di_providers.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/router/navigator.dart';
import 'package:doctor_booking_flutter/src/widgets/init_icon.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';

@RoutePage(name: 'doctorProfile')
class DoctorProfileScreen extends ConsumerWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final Doctor? doctor =
        ref.watch(doctorScheduleStreamProvider(currentUser!.email!)).value;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        //padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Initicon(
                    text: doctor?.fullName ?? '',
                    backgroundColor: context.primary,
                  ),
                  RowSpacing(24.w),
                  KText(
                    doctor?.fullName ?? '',
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
            ),
            ColSpacing(24.h),

            //change all the color of icons in the widget below to context.primary
            /*ListTile(
              leading: Icon(
                Icons.calendar_month,
                color: context.primary,
              ),
              title: Text('Upcoming schedules'),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
            ),*/
            //Divider(),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: context.primary,
              ),
              title: const Text('Settings'),
              trailing: const Icon(Icons.keyboard_arrow_right_sharp),

              onTap: (){
                AppNavigator.of(context).push(const Settings());
              },
            ),
            const Divider(),
            ListTile(
              onTap: () {
                showLicensePage(context: context);
              },
              leading: Icon(
                Icons.privacy_tip,
                color: context.primary,
              ),
              title: const Text('Licenses & Privacy Policy'),
              trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: context.primary,
              ),
              title: const Text('Logout'),
              trailing: const Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (context) => AlertDialog.adaptive(
                          title: const Text('Logout'),
                          content: const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await ref.read(firebaseAuthProvider).signOut();
                                ref.read(storeProvider).removeAll();
                                AppNavigator.of(context)
                                    .replaceAll([const Onboarding()]);
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        ));
              },
            ),
            // Divider(),
          ],
        ),
      ),
    );
  }
}
