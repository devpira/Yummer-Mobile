import 'package:formz/formz.dart';

enum DisplayNameValidationError { invalid, tooShort, invalidChar }

class DisplayNameValueObject
    extends FormzInput<String, DisplayNameValidationError> {
  const DisplayNameValueObject.pure() : super.pure('');
  const DisplayNameValueObject.dirty([String value = '']) : super.dirty(value);

  static final RegExp _displayNameRegExp = RegExp(
    r'^[a-zA-Z0-9._]+$',
  );

  @override
  DisplayNameValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return DisplayNameValidationError.invalid;
    }

    if (value.length < 6) {
      return DisplayNameValidationError.tooShort;
    }

    if (!_displayNameRegExp.hasMatch(value)) {
      return DisplayNameValidationError.invalidChar;
    }

    return null;
  }
}
