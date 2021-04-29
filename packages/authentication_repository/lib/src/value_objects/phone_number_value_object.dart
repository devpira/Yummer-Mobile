import 'package:formz/formz.dart';

enum PhoneNumberError { invalid }

class PhoneNumberValueObject extends FormzInput<String, PhoneNumberError> {
  const PhoneNumberValueObject.pure() : super.pure('');
  const PhoneNumberValueObject.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneRegExp = RegExp(
    r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$',
  );

  @override
  PhoneNumberError? validator(String value) {
    return value == null || value.isEmpty ||  !_phoneRegExp.hasMatch(value) ? PhoneNumberError.invalid : null;
  }
}