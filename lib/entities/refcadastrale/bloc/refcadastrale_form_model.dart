import 'package:formz/formz.dart';
import 'package:sunufoncier/entities/refcadastrale/refcadastrale_model.dart';

enum CodeSectionValidationError { invalid }
class CodeSectionInput extends FormzInput<String, CodeSectionValidationError> {
  const CodeSectionInput.pure() : super.pure('');
  const CodeSectionInput.dirty([String value = '']) : super.dirty(value);

  @override
  CodeSectionValidationError? validator(String value) {
    return null;
  }
}

enum CodeParcelleValidationError { invalid }
class CodeParcelleInput extends FormzInput<String, CodeParcelleValidationError> {
  const CodeParcelleInput.pure() : super.pure('');
  const CodeParcelleInput.dirty([String value = '']) : super.dirty(value);

  @override
  CodeParcelleValidationError? validator(String value) {
    return null;
  }
}

enum NicadValidationError { invalid }
class NicadInput extends FormzInput<String, NicadValidationError> {
  const NicadInput.pure() : super.pure('');
  const NicadInput.dirty([String value = '']) : super.dirty(value);

  @override
  NicadValidationError? validator(String value) {
    return null;
  }
}

enum SuperficiValidationError { invalid }
class SuperficiInput extends FormzInput<double, SuperficiValidationError> {
  const SuperficiInput.pure() : super.pure(0.0);
  const SuperficiInput.dirty([double value = 0.0]) : super.dirty(value);

  @override
  SuperficiValidationError? validator(double value) {
    return null;
  }
}

enum TitreMereValidationError { invalid }
class TitreMereInput extends FormzInput<String, TitreMereValidationError> {
  const TitreMereInput.pure() : super.pure('');
  const TitreMereInput.dirty([String value = '']) : super.dirty(value);

  @override
  TitreMereValidationError? validator(String value) {
    return null;
  }
}

enum TitreCreeValidationError { invalid }
class TitreCreeInput extends FormzInput<String, TitreCreeValidationError> {
  const TitreCreeInput.pure() : super.pure('');
  const TitreCreeInput.dirty([String value = '']) : super.dirty(value);

  @override
  TitreCreeValidationError? validator(String value) {
    return null;
  }
}

enum NumeroRequisitionValidationError { invalid }
class NumeroRequisitionInput extends FormzInput<String, NumeroRequisitionValidationError> {
  const NumeroRequisitionInput.pure() : super.pure('');
  const NumeroRequisitionInput.dirty([String value = '']) : super.dirty(value);

  @override
  NumeroRequisitionValidationError? validator(String value) {
    return null;
  }
}

enum DateBornageValidationError { invalid }
class DateBornageInput extends FormzInput<DateTime?, DateBornageValidationError> {
  const DateBornageInput.pure() : super.pure(null);
  const DateBornageInput.dirty(DateTime value) : super.dirty(value);

  @override
  DateBornageValidationError? validator(DateTime? value) {
    return null;
  }
}

