import 'package:auto_route/annotations.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/patient/home/presentation/ui/widgets/doctor_card.dart';
import 'package:doctor_booking_flutter/app/patient/home/providers.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';

@RoutePage(name: 'patientSearch')
class PatientSearchScreen extends HookConsumerWidget {
  const PatientSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctor = ref.watch(doctorListStreamProvider);
    List<Doctor> initialList = [];
    final filteredList = useState<List<Doctor>>([]);
    final searchController = useTextEditingController();
    bool initialLoad = true;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              TextField(
                controller: searchController,onChanged: (value){
                filteredList.value = initialList
                    .where((element) => element.fullName.contains(
                    value))
                    .toList();
                //if(value.isEmpty){}

              },
                decoration: const InputDecoration(
                    hintText: 'Search doctor here',
                    prefixIcon: Icon(Icons.search)),
              ),
              ColSpacing(24.h),
              doctor.when(
                data: (data) {
                  initialList = data;
                  if(initialLoad){
                    filteredList.value = initialList.toList();
                    initialLoad = false;
                  }

                  if (filteredList.value.isEmpty) {
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
                    itemCount:
                         filteredList.value.length,
                    itemBuilder: (context, index) {
                      return DoctorCard(key: ValueKey('$index'),
                        doctor:
                        filteredList.value[index],
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
      ),
    );
  }
}
