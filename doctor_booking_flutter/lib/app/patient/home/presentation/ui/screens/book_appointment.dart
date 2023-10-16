import 'package:auto_route/auto_route.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctor_booking_flutter/app/common/auth/providers.dart';
import 'package:doctor_booking_flutter/app/common/home/models/appointment.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/patient/home/providers.dart';
import 'package:doctor_booking_flutter/core/service_exceptions/service_exception.dart';
import 'package:doctor_booking_flutter/core/services/add_event_to_calendar.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/widgets/alert_dialog.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';
import 'package:doctor_booking_flutter/src/widgets/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

@RoutePage(name: 'bookAppointment')
class BookAppointmentScreen extends HookConsumerWidget {
  final Doctor doctor;

  const BookAppointmentScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientNoteController = useTextEditingController();
    final User currentUser = ref.watch(currentUserProvider)!;
    List<DateTimeRange> converted = [];
    ValueNotifier<Doctor?> doctorData = useState(null);

    DateTime now = DateTime.now();
    getBookingStream({required DateTime end, required DateTime start}) {
      return ref.watch(doctorScheduleStreamProvider(doctor.emailAddress)).when(
          data: (data) {
            doctorData.value = data;
            return Stream.value(data);
          },
          error: (e, _) {
            return Stream.value(null);
          },
          loading: () => Stream.value(null));
    }

    Future<dynamic> uploadBooking({required BookingService newBooking}) async {
      //check if the patient has booked an appointment with this doctor before
      if (!doctorData.value!.hasPatientBookedPreviously(currentUser.uid)) {
        //show bottomSheet to add patient note
        String? patientNote = await showModalBottomSheet<String?>(
            context: context,
            builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    height: 300.h,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          KText(
                            'Add a note for your appointment',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: patientNoteController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Type note here',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                          ),
                          ColSpacing(16.h),
                          SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: FilledButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context, patientNoteController.text);
                                },
                                child: const Text('Add note'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ));

        if (patientNote != null) {
          Appointment newAppointment = Appointment(
              bookingStart: newBooking.bookingStart,
              bookingEnd: newBooking.bookingEnd,
              patientId: currentUser.uid,
              userEmail: currentUser.email,
              doctorId: doctor.emailAddress,
              doctorName: doctor.fullName,
              doctorSpeciality: doctor.speciality,
              patientNote: patientNote,
              patientName: currentUser.displayName ?? currentUser.email);
          final result = await ref.read(appointmentRepo).bookDoctorAppointment(
              newAppointment: newAppointment,
              doctor: doctor,
              patientEmail: currentUser.email!);
          result.when(success: (data) {
            //go to home screen
            AutoRouter.of(context).popUntilRoot();
            //add appointment to calendar
            //show dialog to notify user that the appointment has been booked and ask if they want to add it to calendar
            showAdaptiveDialog(
              context: context,
              builder: (context) => AlertDialog.adaptive(
                title: const Text('Booking complete'),
                content: const Text(
                    'Your appointment has been booked successfully, do you want to add this appointment to your Calendar?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                  FilledButton.tonal(
                    onPressed: () async {
                      Navigator.pop(context);
                      await CalendarService()
                          .addToCalendar(appointment: newAppointment);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          }, apiFailure: (e, _) {
            //show snackbar to notify user that the appointment failed
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: KText('Failed to book appointment: ${e.message}')));
          });
        }
      } else {
        // notify user that the appointment failed
        Toast.error(
            'You have already an upcoming appointment with this doctor',
            title: 'Unable to book appointment',
            context);
        /* showMessageAlertDialog(context,
            text: 'You have already booked an appointment with this doctor');*/
      }
    }

    List<DateTimeRange> convertStreamResult({required dynamic streamResult}) {
      //if the result is doctor and not null, show the doctor's schedule, else show an empty schedule
      if (streamResult is Doctor) {
        converted = streamResult.scheduleRangeList.toList();
        return streamResult.scheduleRangeList;
      } else {
        return [];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: KText(
          'Book appointment',
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: BookingCalendar(
        key: key,
        bookingGridCrossAxisCount: 4,
        getBookingStream: getBookingStream,
        uploadBooking: uploadBooking,
        convertStreamResultToDateTimeRanges: convertStreamResult,
        uploadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        pauseSlotColor: context.outlineVariant,
        availableSlotColor: context.primary,
        availableSlotTextStyle:
            AppStyle.textStyle.copyWith(color: context.onPrimary),
        pauseSlots: get120Days(),
        hideBreakTime: false,
        bookingButtonColor: context.primaryContainer,
        bookingButtonText: 'Book Appointment',
        disabledDays: const [6, 7],
        bookingService: BookingService(
            serviceName: 'Appointments',
            userEmail: currentUser.email,
            userId: currentUser.uid,
            serviceDuration: 30,
            bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
            bookingStart: DateTime(now.year, now.month, now.day, 8, 0)),
      ),
    );
  }
}

///to blank out all 11:30 to 12:30 for the next 120 days
//function that returns a list of DateTimeRange for the next 120 days where the start for each day is 11:30 am and end is 12:30pm
List<DateTimeRange> get120Days() {
  List<DateTimeRange> converted = [];
  DateTime now = DateTime.now();
  for (int i = 0; i < 120; i++) {
    converted.add(DateTimeRange(
        start: DateTime(now.year, now.month, now.day + i, 11, 30),
        end: DateTime(now.year, now.month, now.day + i, 13, 0)));
  }
  return converted;
}
