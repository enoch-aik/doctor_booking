import 'package:auto_route/annotations.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor_speciality.dart';
import 'package:doctor_booking_flutter/app/patient/calendar/presentation/ui/screens/calendar.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/widgets/doctor_card.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/widgets/doctor_category.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/widgets/upcoming_card.dart';
import 'package:doctor_booking_flutter/app/patient/home/providers.dart';
import 'package:doctor_booking_flutter/app/patient/profile/presentation/ui/screens/profile.dart';
import 'package:doctor_booking_flutter/app/patient/search/presentation/ui/screens/search.dart';
import 'package:doctor_booking_flutter/core/di/di_providers.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/constants/app_constants.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/res/assets/svg.dart';
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
      body: body[ref.watch(selectedHomeIndex)],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          onTap: (index) {
            ref.read(selectedHomeIndex.notifier).state = index;
          },
          currentIndex: ref.watch(selectedHomeIndex),
          items: appNavItems,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
      /*bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: ''),
      ]),*/
    );
  }
}

class _PatientHomeView extends ConsumerWidget {
  const _PatientHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctor = ref.watch(doctorStreamProvider);
    List<Doctor> initialList = [];
    List<Doctor> filteredList = [];
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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          ColSpacing(16.h),
          CategoryHeader(title: 'Upcoming Schedule', onPressed: () {}),
          const UpcomingScheduleCard(),
          ColSpacing(8.h),
          CategoryHeader(
            title: 'Let\'s find your doctor', onPressed: () {}, actionText: '',
            //actionIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: DoctorSpeciality.specialities
                  .map(
                    (e) => DoctorCategoryCard(
                      isSelected:
                          ref.watch(selectedDoctorSpeciality)?.title == e.title,
                      speciality: e,
                      onTap: () {
                        if (ref.watch(selectedDoctorSpeciality)?.title ==
                            e.title) {
                          ref.read(selectedDoctorSpeciality.notifier).state =
                              null;
                        } else {
                          ref.read(selectedDoctorSpeciality.notifier).state = e;
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
    );
  }
}
