import 'package:formz/formz.dart';
import 'package:sunufoncier/entities/ref_parcelaire/ref_parcelaire_model.dart';

enum NumeroParcelleValidationError { invalid }
class NumeroParcelleInput extends FormzInput<String, NumeroParcelleValidationError> {
  const NumeroParcelleInput.pure() : super.pure('');
  const NumeroParcelleInput.dirty([String value = '']) : super.dirty(value);

  @override
  NumeroParcelleValidationError? validator(String value) {
    return null;
  }
}

enum NatureParcelleValidationError { invalid }
class NatureParcelleInput extends FormzInput<String, NatureParcelleValidationError> {
  const NatureParcelleInput.pure() : super.pure('');
  const NatureParcelleInput.dirty([String value = '']) : super.dirty(value);

  @override
  NatureParcelleValidationError? validator(String value) {
    return null;
  }
}

