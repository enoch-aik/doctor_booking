import 'package:auto_route/annotations.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/providers.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';

@RoutePage(name: 'settings')
class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = useState(
        ref.read(themeModeProvider.notifier).state == ThemeMode.light
            ? false
            : true);
    return Scaffold(
      appBar: AppBar(
        title: KText(
          'Settings',
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ColSpacing(32.h),
            KText(
              'Preferences',
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            ColSpacing(8.h),
            SwitchListTile.adaptive(
              secondary: Icon(
                themeState.value
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                size: 24.sp,
              ),
              title: KText(
                themeState.value ? 'Dark Mode' : 'Light Mode',
                fontSize: 17.sp,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              value: themeState.value,
              onChanged: (value) {
                themeState.value = value;
                //switch the app's theme
                ref.read(themeModeProvider.notifier).state =
                    value ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ],
        ),
      ),
    );
  }
}
