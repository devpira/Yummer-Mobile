import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class NameValueObject extends FormzInput<String, NameValidationError> {
  const NameValueObject.pure() : super.pure('');
  const NameValueObject.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError validator(String value) {
    return value == null || value.isEmpty ? NameValidationError.invalid : null;
  }
}
