import 'package:formz/formz.dart';

// Define input validation errors
enum TitleError { empty, format }

// Extend FormzInput and provide the input type and error type.
class TitleValidator extends FormzInput<String, TitleError> {
  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // Call super.pure to represent an unmodified form input.
  const TitleValidator.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const TitleValidator.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TitleError.empty) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  TitleError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TitleError.empty;

    return null;
  }
}
