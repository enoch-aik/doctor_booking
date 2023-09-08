//Validator for all textfields

class TextFieldValidator {
  TextFieldValidator._();
  //Email validator
  static final RegExp emailExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\['
    r'[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
    r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );
  //Validator for name
  static final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
  //Validator for number
  static final RegExp numberExp = RegExp(r'^[0-9]+$');

  static String? nameValidator({required String value}) {
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value.isEmpty) {
      return 'Your name is required';
    }

    if (!nameExp.hasMatch(value)) {
      return 'This name is not valid';
    }
    return null;
  }

  static String? emailValidator({required String? value}) {
    final RegExp emailExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\['
      r'[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
      r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    if (value!.isEmpty) {
      return 'Your email is required';
    }
    if (!emailExp.hasMatch(value)) {
      return 'This is not a valid email address';
    }
    return null;
  }

  phoneNumberValidator({required String? value}) {
    if (value!.isEmpty) {
      return 'Phone number required';
    }
    if (value.length < 10) {
      return 'Phone number not valid';
    }
    return null;
  }
}
