import 'package:formz/formz.dart';

enum CardExpiryDateValidationError { invalid }

class CardExpiryDateValueObject extends FormzInput<String, CardExpiryDateValidationError> {
  const CardExpiryDateValueObject.pure() : super.pure('');
  const CardExpiryDateValueObject.dirty([String value = '']) : super.dirty(value);

  @override
  CardExpiryDateValidationError? validator(String value) {
    return value == null || value.isEmpty || value.length != 4 ? CardExpiryDateValidationError.invalid : null;
  }
}
