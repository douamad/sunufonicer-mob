import 'dart:ffi';

import 'package:formz/formz.dart';
import 'package:sunufoncier/entities/categorie_batie/categorie_batie_model.dart';

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
  const PrixMetreCareInput.pure() : super.pure(null);
  const PrixMetreCareInput.dirty([double? value = null]) : super.dirty(value);

  @override
  PrixMetreCareValidationError? validator(double? value) {
    return null;
  }
}

