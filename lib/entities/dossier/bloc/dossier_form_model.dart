import 'package:formz/formz.dart';
import 'package:sunufoncier/entities/dossier/dossier_model.dart';

enum NumeroValidationError { invalid }
class NumeroInput extends FormzInput<String, NumeroValidationError> {
  const NumeroInput.pure() : super.pure('');
  const NumeroInput.dirty([String value = '']) : super.dirty(value);

  @override
  NumeroValidationError? validator(String value) {
    return null;
  }
}

enum MontantLoyerValidationError { invalid }
class MontantLoyerInput extends FormzInput<double, MontantLoyerValidationError> {
  const MontantLoyerInput.pure() : super.pure(0.0);
  const MontantLoyerInput.dirty([double value = 0.0]) : super.dirty(value);

  @override
  MontantLoyerValidationError? validator(double value) {
    return null;
  }
}

enum SuperficieBatieValidationError { invalid }
class SuperficieBatieInput extends FormzInput<double, SuperficieBatieValidationError> {
  const SuperficieBatieInput.pure() : super.pure(0.0);
  const SuperficieBatieInput.dirty([double value = 0.0]) : super.dirty(value);

  @override
  SuperficieBatieValidationError? validator(double value) {
    return null;
  }
}

enum CoeffCorrectifBatieValidationError { invalid }
class CoeffCorrectifBatieInput extends FormzInput<double, CoeffCorrectifBatieValidationError> {
  const CoeffCorrectifBatieInput.pure() : super.pure(0.0);
  const CoeffCorrectifBatieInput.dirty([double value = 0.0]) : super.dirty(value);

  @override
  CoeffCorrectifBatieValidationError? validator(double value) {
    return null;
  }
}

enum ValeurBatieValidationError { invalid }
class ValeurBatieInput extends FormzInput<double, ValeurBatieValidationError> {
  const ValeurBatieInput.pure() : super.pure(0.0);
  const ValeurBatieInput.dirty([double value = 0.0]) : super.dirty(value);

  @override
  ValeurBatieValidationError? validator(double value) {
    return null;
  }
}

enum LineaireClotureValidationError { invalid }
class LineaireClotureInput extends FormzInput<double, LineaireClotureValidationError> {
  const LineaireClotureInput.pure() : super.pure(0.0);
  const LineaireClotureInput.dirty([double value = 0.0]) : super.dirty(value);

  @override
  LineaireClotureValidationError? validator(double value) {
    return null;
  }
}

enum CoeffClotureValidationError { invalid }
class CoeffClotureInput extends FormzInput<double, CoeffClotureValidationError> {
  const CoeffClotureInput.pure() : super.pure(0.0);
  const CoeffClotureInput.dirty([double value = 0.0]) : super.dirty(value);

  @override
  CoeffClotureValidationError? validator(double value) {
    return null;
  }
}

enum ValeurClotureValidationError { invalid }
class ValeurClotureInput extends FormzInput<double, ValeurClotureValidationError> {
  const ValeurClotureInput.pure() : super.pure(0.0);
  const ValeurClotureInput.dirty([double value = 0.0]) : super.dirty(value);

  @override
  ValeurClotureValidationError? validator(double value) {
    return null;
  }
}

enum AmenagementSpaciauxValidationError { invalid }
class AmenagementSpaciauxInput extends FormzInput<String, AmenagementSpaciauxValidationError> {
  const AmenagementSpaciauxInput.pure() : super.pure('');
  const AmenagementSpaciauxInput.dirty([String value = '']) : super.dirty(value);

  @override
  AmenagementSpaciauxValidationError? validator(String value) {
    return null;
  }
}

enum ValeurAmenagementValidationError { invalid }
class ValeurAmenagementInput extends FormzInput<double, ValeurAmenagementValidationError> {
  const ValeurAmenagementInput.pure() : super.pure(0.0);
  const ValeurAmenagementInput.dirty([double value = 0.0]) : super.dirty(value);

  @override
  ValeurAmenagementValidationError? validator(double value) {
    return null;
  }
}

enum ValeurVenaleValidationError { invalid }
class ValeurVenaleInput extends FormzInput<double, ValeurVenaleValidationError> {
  const ValeurVenaleInput.pure() : super.pure(0.0);
  const ValeurVenaleInput.dirty([double value = 0.0]) : super.dirty(value);

  @override
  ValeurVenaleValidationError? validator(double value) {
    return null;
  }
}

enum ValeurLocativValidationError { invalid }
class ValeurLocativInput extends FormzInput<String, ValeurLocativValidationError> {
  const ValeurLocativInput.pure() : super.pure('');
  const ValeurLocativInput.dirty([String value = '']) : super.dirty(value);

  @override
  ValeurLocativValidationError? validator(String value) {
    return null;
  }
}

