import 'package:auto_route/annotations.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/widgets/upcoming_card.dart';
import 'package:doctor_booking_flutter/lib.dart';

@RoutePage(name: 'upcomingSchedules')
class UpcomingSchedulesScreen extends StatelessWidget {
  final List<Appointment> appointments;

  const UpcomingSchedulesScreen({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: KText(
          'Upcoming Schedules',
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: ListView.separated(padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 40.h),
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: const Divider(
            height: 0,thickness: 0.1,
          ),
        ),
        itemBuilder: (context, index) =>
        UpcomingScheduleCard(appointment: appointments[index],)
        /*Container(
          height: 150.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
child: Column(children: [],),
        )*/,
        itemCount: appointments.length,
      ),
    );
  }
}
