import 'package:formz/formz.dart';

enum CardCvvValidationError { invalid }

class CardCvvValueObject extends FormzInput<String, CardCvvValidationError> {
  const CardCvvValueObject.pure() : super.pure('');
  const CardCvvValueObject.dirty([String value = '']) : super.dirty(value);

  @override
  CardCvvValidationError? validator(String value) {
    return value == null || value.isEmpty || value.length != 3
        ? CardCvvValidationError.invalid
        : null;
  }
}
