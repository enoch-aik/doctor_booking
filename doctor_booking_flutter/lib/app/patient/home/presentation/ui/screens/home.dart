import 'package:auto_route/annotations.dart';
import 'package:doctor_booking_flutter/app/common/auth/providers.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor_speciality.dart';
import 'package:doctor_booking_flutter/app/patient/calendar/presentation/ui/screens/calendar.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/widgets/doctor_card.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/widgets/doctor_category.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/widgets/upcoming_card.dart';
import 'package:doctor_booking_flutter/app/patient/home/providers.dart';
import 'package:doctor_booking_flutter/app/patient/profile/presentation/ui/screens/profile.dart';
import 'package:doctor_booking_flutter/app/patient/search/presentation/ui/screens/search.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/constants/app_constants.dart';
import 'package:doctor_booking_flutter/src/constants/assets.dart';
import 'package:doctor_booking_flutter/src/res/assets/svg.dart';
import 'package:doctor_booking_flutter/src/router/navigator.dart';
import 'package:doctor_booking_flutter/src/widgets/category_header.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';

@RoutePage(name: 'patientHome')
class PatientHomeScreen extends ConsumerWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<Widget> body = [
      _PatientHomeView(),
      PatientSearchScreen(),
      PatientCalendarScreen(),
      PatientProfileScreen()
    ];

    return Scaffold(
      body: body[ref.watch(patientSelectedHomeIndex)],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          onTap: (index) {
            ref.read(patientSelectedHomeIndex.notifier).state = index;
          },
          currentIndex: ref.watch(patientSelectedHomeIndex),
          items: patientAppNavItems,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}

class _PatientHomeView extends HookConsumerWidget {
  const _PatientHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctor = ref.watch(doctorListStreamProvider);
    List<Doctor> initialList = [];
    List<Doctor> filteredList = [];
    final appointments = ref.watch(patientAppointmentsStreamProvider(
        ref.read(currentUserProvider)!.email!));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            icDrawer,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              icNotification,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        //refresh both upcoming schedule and doctor list
        onRefresh: () async => await Future.wait([
          ref.refresh(patientAppointmentsStreamProvider(
                  ref.read(currentUserProvider)!.email!)
              .future),
          ref.refresh(doctorListStreamProvider.future)
        ]),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            ColSpacing(16.h),
            appointments.when(
              data: (patient) {
                if (patient.upcomingAppointments.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const KText(
                        'No upcoming appointment found',
                        fontWeight: FontWeight.w500,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: SvgPicture.asset(
                          AppAssets.emptySvg,
                          height: 100.h,
                        ),
                      ),
                    ],
                  );
                }

                patient.upcomingAppointments
                    .sort((a, b) => a.bookingStart!.compareTo(b.bookingStart!));
                final firstAppointment = patient.upcomingAppointments.first;
                return Column(
                  children: [
                    CategoryHeader(
                      title: 'Upcoming Schedules',
                      onPressed: () {
                        //navigate to upcoming schedules
                        AppNavigator.of(context).push(
                          UpcomingSchedules(
                              appointments: patient.upcomingAppointments),
                        );
                      },
                    ),
                    UpcomingScheduleCard(
                      appointment: firstAppointment,
                    ),
                  ],
                );
              },
              error: (e, _) => const UpcomingScheduleCard(),
              loading: () => const UpcomingScheduleCard(),
            ),
            ColSpacing(8.h),
            CategoryHeader(
              title: 'Let\'s find your doctor',
              onPressed: () {},
              actionText: '',
              //actionIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: DoctorSpeciality.specialities
                    .map(
                      (e) => DoctorCategoryCard(
                        isSelected:
                            ref.watch(selectedDoctorSpeciality)?.title ==
                                e.title,
                        speciality: e,
                        onTap: () {
                          if (ref.watch(selectedDoctorSpeciality)?.title ==
                              e.title) {
                            ref.read(selectedDoctorSpeciality.notifier).state =
                                null;
                          } else {
                            ref.read(selectedDoctorSpeciality.notifier).state =
                                e;
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            ColSpacing(16.h),
            doctor.when(
              data: (data) {
                initialList = data;
                filteredList = initialList
                    .where((element) => element.speciality.contains(
                        ref.watch(selectedDoctorSpeciality)?.title ?? ''))
                    .toList();
                List<Doctor> currentList =
                    ref.watch(selectedDoctorSpeciality) == null
                        ? initialList
                        : filteredList;
                if (currentList.isEmpty) {
                  return SizedBox(
                    height: 300.h,
                    child: const Center(
                      child: KText(
                        'No doctor found, please check in later',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ref.watch(selectedDoctorSpeciality) == null
                      ? data.length
                      : filteredList.length,
                  itemBuilder: (context, index) {
                    return DoctorCard(
                      doctor: ref.watch(selectedDoctorSpeciality) == null
                          ? data[index]
                          : filteredList[index],
                    );
                  },
                );
              },
              error: (e, _) {
                return const SizedBox();
              },
              loading: () => SizedBox(
                height: 300.h,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
