import 'package:formz/formz.dart';
import 'package:sunufoncier/entities/proprietaire/proprietaire_model.dart';

enum PrenomValidationError { invalid }
class PrenomInput extends FormzInput<String, PrenomValidationError> {
  const PrenomInput.pure() : super.pure('');
  const PrenomInput.dirty([String value = '']) : super.dirty(value);

  @override
  PrenomValidationError? validator(String value) {
    return null;
  }
}

enum NomValidationError { invalid }
class NomInput extends FormzInput<String, NomValidationError> {
  const NomInput.pure() : super.pure('');
  const NomInput.dirty([String value = '']) : super.dirty(value);

  @override
  NomValidationError? validator(String value) {
    return null;
  }
}

enum SituationValidationError { invalid }
class SituationInput extends FormzInput<SituationProprietaire, SituationValidationError> {
  const SituationInput.pure() : super.pure(SituationProprietaire.RESIDENT);
  const SituationInput.dirty(SituationProprietaire value) : super.dirty(value);

  @override
  SituationValidationError? validator(SituationProprietaire value) {
    return null;
  }
}

enum RaisonSocialValidationError { invalid }
class RaisonSocialInput extends FormzInput<String, RaisonSocialValidationError> {
  const RaisonSocialInput.pure() : super.pure('');
  const RaisonSocialInput.dirty([String value = '']) : super.dirty(value);

  @override
  RaisonSocialValidationError? validator(String value) {
    return null;
  }
}

enum PersonneMoraleValidationError { invalid }
class PersonneMoraleInput extends FormzInput<bool, PersonneMoraleValidationError> {
  const PersonneMoraleInput.pure() : super.pure(false);
  const PersonneMoraleInput.dirty([bool value = false]) : super.dirty(value);

  @override
  PersonneMoraleValidationError? validator(bool value) {
    return null;
  }
}

enum DateNaissValidationError { invalid }
class DateNaissInput extends FormzInput<DateTime?, DateNaissValidationError> {
  const DateNaissInput.pure() : super.pure(null);
  const DateNaissInput.dirty(DateTime value) : super.dirty(value);

  @override
  DateNaissValidationError? validator(DateTime? value) {
    return null;
  }
}

enum LieuNaissanceValidationError { invalid }
class LieuNaissanceInput extends FormzInput<String, LieuNaissanceValidationError> {
  const LieuNaissanceInput.pure() : super.pure('');
  const LieuNaissanceInput.dirty([String value = '']) : super.dirty(value);

  @override
  LieuNaissanceValidationError? validator(String value) {
    return null;
  }
}

enum NumCNIValidationError { invalid }
class NumCNIInput extends FormzInput<String, NumCNIValidationError> {
  const NumCNIInput.pure() : super.pure('');
  const NumCNIInput.dirty([String value = '']) : super.dirty(value);

  @override
  NumCNIValidationError? validator(String value) {
    return null;
  }
}

enum NineaValidationError { invalid }
class NineaInput extends FormzInput<String, NineaValidationError> {
  const NineaInput.pure() : super.pure('');
  const NineaInput.dirty([String value = '']) : super.dirty(value);

  @override
  NineaValidationError? validator(String value) {
    return null;
  }
}

enum AdresseValidationError { invalid }
class AdresseInput extends FormzInput<String, AdresseValidationError> {
  const AdresseInput.pure() : super.pure('');
  const AdresseInput.dirty([String value = '']) : super.dirty(value);

  @override
  AdresseValidationError? validator(String value) {
    return null;
  }
}

enum EmailValidationError { invalid }
class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    return null;
  }
}

enum TelephoneValidationError { invalid }
class TelephoneInput extends FormzInput<String, TelephoneValidationError> {
  const TelephoneInput.pure() : super.pure('');
  const TelephoneInput.dirty([String value = '']) : super.dirty(value);

  @override
  TelephoneValidationError? validator(String value) {
    return null;
  }
}

enum Telephone2ValidationError { invalid }
class Telephone2Input extends FormzInput<String, Telephone2ValidationError> {
  const Telephone2Input.pure() : super.pure('');
  const Telephone2Input.dirty([String value = '']) : super.dirty(value);

  @override
  Telephone2ValidationError? validator(String value) {
    return null;
  }
}

enum Telephone3ValidationError { invalid }
class Telephone3Input extends FormzInput<String, Telephone3ValidationError> {
  const Telephone3Input.pure() : super.pure('');
  const Telephone3Input.dirty([String value = '']) : super.dirty(value);

  @override
  Telephone3ValidationError? validator(String value) {
    return null;
  }
}

enum AquisitionValidationError { invalid }
class AquisitionInput extends FormzInput<String, AquisitionValidationError> {
  const AquisitionInput.pure() : super.pure('');
  const AquisitionInput.dirty([String value = '']) : super.dirty(value);

  @override
  AquisitionValidationError? validator(String value) {
    return null;
  }
}

enum StatutPersoneStructureValidationError { invalid }
class StatutPersoneStructureInput extends FormzInput<String, StatutPersoneStructureValidationError> {
  const StatutPersoneStructureInput.pure() : super.pure('');
  const StatutPersoneStructureInput.dirty([String value = '']) : super.dirty(value);

  @override
  StatutPersoneStructureValidationError? validator(String value) {
    return null;
  }
}

enum TypeStructureValidationError { invalid }
class TypeStructureInput extends FormzInput<TypeStructure, TypeStructureValidationError> {
  const TypeStructureInput.pure() : super.pure(TypeStructure.ENTREPRISE_INDIVIDUEL);
  const TypeStructureInput.dirty(TypeStructure value) : super.dirty(value);

  @override
  TypeStructureValidationError? validator(TypeStructure value) {
    return null;
  }
}

