import 'package:auto_route/auto_route.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/res/assets/svg.dart';
import 'package:doctor_booking_flutter/src/router/navigator.dart';
import 'package:doctor_booking_flutter/src/widgets/init_icon.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';

class ValorDrawer extends ConsumerWidget {
  const ValorDrawer({
    super.key,
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Material(
      color: context.primary,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: onClose,
                  splashRadius: 25,
                  icon: Icon(
                    Icons.close_rounded,
                    color: context.onPrimary,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         const Initicon(text: 'Enoch Aik'),
                       ColSpacing(12.h),
                        const KText('Enoch Aik'),
                       ColSpacing(8.h),
TextButton(onPressed: (){}, child: const Text('My profile')),

                      ],
                    ),
                    const Divider(
                      //color: valorColors.orange,
                    ),
                    ..._DrawerItem.drawerItems
                        .map(
                          (drawerItem) =>
                         _DrawerItemTile(
                          label: drawerItem.label,
                          asset: drawerItem.asset,
                          onTap: () {
                            onClose();

                            AppNavigator.of(context).push(
                              drawerItem.routeTo,
                            );
                          },
                        ),
                    )
                        .toList(),
                    ColSpacing(24.h),
                    _DrawerItemTile(
                      label: 'Logout',
                      asset: userSvg,
                      onTap: () async {
                       // ref.read(logoutProvider.notifier).logout();
                        onClose();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItemTile extends StatelessWidget {
  const _DrawerItemTile({
    required this.onTap,
    required this.asset,
    required this.label,
  });

  final VoidCallback onTap;
  final String asset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(asset),
      title: Text(
        label,
      ),
      textColor: context.onPrimary,
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }
}

class _DrawerItem {
  final String label;
  final String asset;
  final PageRouteInfo routeTo;
  final String? description;

  _DrawerItem({
    required this.label,
    required this.asset,
    required this.routeTo,
    this.description,
  });

  static final drawerItems = <_DrawerItem>[
    _DrawerItem(
      label: 'Upcoming trips',
      asset: '',
      routeTo: const PatientHome(),
      description: 'Click to show list of upcoming trips.',
    ),
    /*_DrawerItem(
      label: 'Request History',
      asset: icRequests,
      routeTo: const HistoryRoute(),
      description: 'Click to show list of completed trips.',
    ),

    _DrawerItem(
      label: 'Notification Settings',
      asset: icNotificationSettings,
      routeTo: const NotificationsRoute(),
    ),
    _DrawerItem(
      label: 'Help',
      asset: icHelp,
      routeTo: const GetHelpRoute(),
    ),
    _DrawerItem(
      label: 'Privacy',
      asset: icInfo,
      routeTo: const PrivacyRoute(),
    ),
    _DrawerItem(
      label: 'Terms and conditions',
      asset: icInfo,
      routeTo: const TermsOfServiceRoute(),
    ),*/
  ];
}
