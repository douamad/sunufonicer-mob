import 'package:formz/formz.dart';
import 'package:sunufoncier/entities/categorie_cloture/categorie_cloture_model.dart';

enum LibelleValidationError { invalid }
class LibelleInput extends FormzInput<String, LibelleValidationError> {
  const LibelleInput.pure() : super.pure('');
  const LibelleInput.dirty([String value = '']) : super.dirty(value);

  @override
  LibelleValidationError? validator(String value) {
    return null;
  }
}

enum PrixMetreCareValidationError { invalid }
class PrixMetreCareInput extends FormzInput<double?, PrixMetreCareValidationError> {
  const PrixMetreCareInput.pure() : super.pure(0.0);
  const PrixMetreCareInput.dirty([double value = 0.0]) : super.dirty(value);

  @override
  PrixMetreCareValidationError? validator(double? value) {
    return null;
  }
}

