import 'package:formz/formz.dart';

enum CardNumberValidationError { invalid }

class CardNumberValueObject extends FormzInput<String, CardNumberValidationError> {
  const CardNumberValueObject.pure() : super.pure('');
  const CardNumberValueObject.dirty([String value = '']) : super.dirty(value);

  @override
  CardNumberValidationError? validator(String value) {
    return value == null || value.isEmpty ? CardNumberValidationError.invalid : null;
  }
}
