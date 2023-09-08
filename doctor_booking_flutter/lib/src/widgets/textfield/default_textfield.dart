
import 'package:doctor_booking_flutter/lib.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? emptyTextError;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const DefaultTextFormField(
      {Key? key,
      this.controller,
      this.label,
      this.validator,
      this.hint,
      this.helperText,
      this.maxLines,
      this.emptyTextError,this.keyboardType,
      this.minLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(/*
      maxLines: maxLines,
      minLines: minLines,*/
      controller: controller,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return emptyTextError;
            }
            return null;
          },
      keyboardType: keyboardType,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 1),
          hintText: hint,
          labelText: label,
          helperText: helperText),
    );
  }
}
