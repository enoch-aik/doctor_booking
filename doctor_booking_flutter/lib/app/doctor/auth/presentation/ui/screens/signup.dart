import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:doctor_booking_flutter/app/common/auth/domain/params/new_doctor.dart';
import 'package:doctor_booking_flutter/app/common/auth/providers.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor.dart';
import 'package:doctor_booking_flutter/app/doctor/auth/data/models/doctor_speciality.dart';
import 'package:doctor_booking_flutter/core/di/di_providers.dart';
import 'package:doctor_booking_flutter/core/service_exceptions/src/api_exceptions.dart';
import 'package:doctor_booking_flutter/core/validators/text_field_validators.dart';
import 'package:doctor_booking_flutter/lib.dart';
import 'package:doctor_booking_flutter/src/extensions/context.dart';
import 'package:doctor_booking_flutter/src/router/navigator.dart';
import 'package:doctor_booking_flutter/src/widgets/alert_dialog.dart';
import 'package:doctor_booking_flutter/src/widgets/loader/loader.dart';
import 'package:doctor_booking_flutter/src/widgets/margin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage(name: 'doctorSignup')
class DoctorSignupScreen extends HookConsumerWidget {
  const DoctorSignupScreen({super.key});

  static final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final fullNameController = useTextEditingController();
    final passwordController = useTextEditingController();
    AutovalidateMode validateMode = AutovalidateMode.onUserInteraction;
    final auth = ref.read(authRepoProvider);
    final speciality = useState<DoctorSpeciality?>(null);

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            ColSpacing(16.h),
            KText(
              'Welcome!👋',
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
              color: context.primary,
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                duration: const Duration(seconds: 2), color: context.onPrimary),
            KText(
              'Please fill in the details below to create your account',
              fontSize: 16.sp,
            ),
            SizedBox(
              height: 32.h,
            ),

            DefaultTextFormField(
              label: 'Full name',
              hint: 'Type your full name here',
              controller: fullNameController,
              emptyTextError: 'Full name is required',
              keyboardType: TextInputType.name,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Full Name is required';
                } else if (value.isNotEmpty &&
                    !TextFieldValidator.nameExp.hasMatch(value)) {
                  return 'Full Name is not valid';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            //email textField
            DefaultTextFormField(
              label: 'Email address',
              hint: 'user@example.com',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Email address is required';
                } else if (value.isNotEmpty &&
                    !TextFieldValidator.emailExp.hasMatch(value)) {
                  return 'Email address not valid';
                }
                return null;
              },
            ),
            ColSpacing(16.h),
            //speciality dropdown
            DropdownButtonFormField<DoctorSpeciality>(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      left: 8,
                    ),
                    prefix: KText(
                      '🩺',
                      color: context.primary,
                    ),
                    labelText: 'Choose a speciality'),
                value: speciality.value,
                items: DoctorSpeciality.specialities
                    .map((e) => DropdownMenuItem<DoctorSpeciality>(
                        value: e, child: Text(e.title)))
                    .toList(),
                onChanged: (value) {
                  speciality.value = value;
                }),

            //password textField
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: PasswordTextField(
                  label: 'Password',
                  controller: passwordController,
                  emptyTextError: 'Password is required',
                  isSignUp: true),
            ),
            SizedBox(
              height: 32.h,
            ),
            FilledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Loader.show(context);
                    //get fcmToken
                    String? fcmToken = '';
                    if (Platform.isAndroid) {
                      fcmToken = await FirebaseMessaging.instance.getToken();
                    }
                    NewDoctor doctor = NewDoctor(
                        fullName: fullNameController.text,
                        emailAddress: emailController.text,
                        password: passwordController.text,
                        fcmToken: fcmToken,
                        speciality: speciality.value!.title);

                    final result = await auth.doctorSignUp(doctor);

                    result.when(success: (data) async {
                      final firebaseDb = ref.read(firebaseApiProvider);
                      bool stored = await firebaseDb.storeDoctorData(
                          newDoctor: doctor, credential: data);
                      Loader.hide(context);

                      if (stored) {
                        ref.read(storeProvider).saveDoctorInfo(Doctor(
                            fullName: doctor.fullName,
                            emailAddress: doctor.emailAddress,
                            speciality: doctor.speciality));

                        //take user to doctor home
                        AppNavigator.of(context)
                            .replaceAll([const DoctorHome()]);
                      }
                    }, apiFailure: (e, _) {
                      Loader.hide(context);
                      showMessageAlertDialog(context, text: e.message);
                    });
                  }
                },
                child: const Text('Create Doctor Account'))
          ],
        ),
      ),
    );
  }
}
