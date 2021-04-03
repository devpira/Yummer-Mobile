import 'package:formz/formz.dart';

enum CardNameValidationError { invalid }

class CardNameValueObject extends FormzInput<String, CardNameValidationError> {
  const CardNameValueObject.pure() : super.pure('');
  const CardNameValueObject.dirty([String value = '']) : super.dirty(value);

  @override
  CardNameValidationError validator(String value) {
    return value == null || value.isEmpty ? CardNameValidationError.invalid : null;
  }
}
