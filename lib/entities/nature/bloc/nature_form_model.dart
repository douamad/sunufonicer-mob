import 'package:formz/formz.dart';
import 'package:sunufoncier/entities/nature/nature_model.dart';

enum CodeValidationError { invalid }
class CodeInput extends FormzInput<String, CodeValidationError> {
  const CodeInput.pure() : super.pure('');
  const CodeInput.dirty([String value = '']) : super.dirty(value);

  @override
  CodeValidationError? validator(String value) {
    return null;
  }
}

enum LibelleValidationError { invalid }
class LibelleInput extends FormzInput<String, LibelleValidationError> {
  const LibelleInput.pure() : super.pure('');
  const LibelleInput.dirty([String value = '']) : super.dirty(value);

  @override
  LibelleValidationError? validator(String value) {
    return null;
  }
}

