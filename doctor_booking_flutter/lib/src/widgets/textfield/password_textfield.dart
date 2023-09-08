import 'package:doctor_booking_flutter/lib.dart';

class PasswordTextField extends HookWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? emptyTextError;
  final String? Function(String?)? validator;
  final bool isSignUp;

  const PasswordTextField(
      {Key? key,
      this.controller,
      this.label,
      this.hint,
      this.helperText,
      this.emptyTextError,
      this.validator,
      this.isSignUp = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true);
    return Column(
      children: [
        TextFormField(
            maxLines: 1,
            controller: controller,
            validator: validator ??
                (value) {
                  value?.trim();
                  if (value == null || value.isEmpty) {
                    return emptyTextError;
                  } else if (value.length < 6) {
                    return 'Password must be at-least 6 characters';
                  }
                  return null;
                },
            obscureText: obscureText.value,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10, top: 1),
                hintText: hint,
                labelText: label,
                helperText: helperText,
                suffixIcon: InkWell(
                  onTap: () {
                    obscureText.value = !obscureText.value;
                  },
                  child: Icon(obscureText.value
                      ? Icons.visibility
                      : Icons.visibility_off_rounded),
                ))),
        SizedBox(
          height: 24.h,
        ),
        if (isSignUp)
          TextFormField(
              maxLines: 1,
              validator: (value) {
                value?.trim();
                if (value!.isEmpty || value != controller!.text) {
                  return 'Password does not match';
                }
                return null;
              },
              obscureText: obscureText.value,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10, top: 1),
                  hintText: hint,
                  labelText: 'Confirm password',
                  helperText: helperText,
                  suffixIcon: InkWell(
                    onTap: () {
                      obscureText.value = !obscureText.value;
                    },
                    child: Icon(obscureText.value
                        ? Icons.visibility
                        : Icons.visibility_off_rounded),
                  )))
      ],
    );
  }
}
