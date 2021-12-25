import '../formz.dart';

enum DefaultValidationError { invalid }

class Default extends FormzInput<String?, DefaultValidationError> {
  const Default.pure() : super.pure('');

  const Default.dirty([String? value = '']) : super.dirty(value);

  @override
  DefaultValidationError? validator(String? value) {
    return value!.isNotEmpty ? null : DefaultValidationError.invalid;
  }
}