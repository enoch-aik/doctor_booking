import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:doctor_booking_flutter/app/common/auth/providers.dart';
import 'package:doctor_booking_flutter/app/doctor/home/data/models/custom_appointment.dart';
import 'package:doctor_booking_flutter/app/doctor/home/presentation/ui/screens/home.dart';
import 'package:doctor_booking_flutter/app/patient/home/providers.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/extensions/appointment_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

@RoutePage(name: 'patientCalendar')
class PatientCalendarScreen extends HookConsumerWidget {
  const PatientCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(patientAppointmentsStreamProvider(
        ref.read(currentUserProvider)!.email!));
    return Scaffold(
      //appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.only(top: 80.h),
          child: appointments.when(
              data: (data) {
                return getScheduleViewCalendar(
                    scheduleViewBuilder: scheduleViewBuilder,
                    context: context,
                    sources: data.appointments.toSyncfusionAppointment(isDoctor: false));
              },
              error: (e, _) {
                return getScheduleViewCalendar(
                    context: context,
                    scheduleViewBuilder: scheduleViewBuilder,
                    sources: []);
              },
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ))),
    );
  }

  SfCalendar getScheduleViewCalendar(
      {dynamic scheduleViewBuilder,
      required List<CustomAppointment> sources,
      required BuildContext context}) {
    return SfCalendar(
      showDatePickerButton: true,
      scheduleViewMonthHeaderBuilder: scheduleViewBuilder,
      view: CalendarView.schedule,
      //onTap: onAppointmentTap,
      firstDayOfWeek: 1,
      dataSource: _DataSource(sources),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
