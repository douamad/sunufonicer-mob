part of 'proprietaire_bloc.dart';

abstract class ProprietaireEvent extends Equatable {
  const ProprietaireEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitProprietaireList extends ProprietaireEvent {}

class PrenomChanged extends ProprietaireEvent {
  final String prenom;

  const PrenomChanged({required this.prenom});

  @override
  List<Object> get props => [prenom];
}
class NomChanged extends ProprietaireEvent {
  final String nom;

  const NomChanged({required this.nom});

  @override
  List<Object> get props => [nom];
}
class SituationChanged extends ProprietaireEvent {
  final SituationProprietaire situation;

  const SituationChanged({required this.situation});

  @override
  List<Object> get props => [situation];
}
class RaisonSocialChanged extends ProprietaireEvent {
  final String raisonSocial;

  const RaisonSocialChanged({required this.raisonSocial});

  @override
  List<Object> get props => [raisonSocial];
}
class PersonneMoraleChanged extends ProprietaireEvent {
  final bool personneMorale;

  const PersonneMoraleChanged({required this.personneMorale});

  @override
  List<Object> get props => [personneMorale];
}
class DateNaissChanged extends ProprietaireEvent {
  final DateTime dateNaiss;

  const DateNaissChanged({required this.dateNaiss});

  @override
  List<Object> get props => [dateNaiss];
}
class LieuNaissanceChanged extends ProprietaireEvent {
  final String lieuNaissance;

  const LieuNaissanceChanged({required this.lieuNaissance});

  @override
  List<Object> get props => [lieuNaissance];
}
class NumCNIChanged extends ProprietaireEvent {
  final String numCNI;

  const NumCNIChanged({required this.numCNI});

  @override
  List<Object> get props => [numCNI];
}
class NineaChanged extends ProprietaireEvent {
  final String ninea;

  const NineaChanged({required this.ninea});

  @override
  List<Object> get props => [ninea];
}
class AdresseChanged extends ProprietaireEvent {
  final String adresse;

  const AdresseChanged({required this.adresse});

  @override
  List<Object> get props => [adresse];
}
class EmailChanged extends ProprietaireEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}
class TelephoneChanged extends ProprietaireEvent {
  final String telephone;

  const TelephoneChanged({required this.telephone});

  @override
  List<Object> get props => [telephone];
}
class Telephone2Changed extends ProprietaireEvent {
  final String telephone2;

  const Telephone2Changed({required this.telephone2});

  @override
  List<Object> get props => [telephone2];
}
class Telephone3Changed extends ProprietaireEvent {
  final String telephone3;

  const Telephone3Changed({required this.telephone3});

  @override
  List<Object> get props => [telephone3];
}
class AquisitionChanged extends ProprietaireEvent {
  final String aquisition;

  const AquisitionChanged({required this.aquisition});

  @override
  List<Object> get props => [aquisition];
}
class StatutPersoneStructureChanged extends ProprietaireEvent {
  final String statutPersoneStructure;

  const StatutPersoneStructureChanged({required this.statutPersoneStructure});

  @override
  List<Object> get props => [statutPersoneStructure];
}
class TypeStructureChanged extends ProprietaireEvent {
  final TypeStructure typeStructure;

  const TypeStructureChanged({required this.typeStructure});

  @override
  List<Object> get props => [typeStructure];
}

class ProprietaireFormSubmitted extends ProprietaireEvent {}

class LoadProprietaireByIdForEdit extends ProprietaireEvent {
  final int? id;

  const LoadProprietaireByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteProprietaireById extends ProprietaireEvent {
  final int? id;

  const DeleteProprietaireById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadProprietaireByIdForView extends ProprietaireEvent {
  final int? id;

  const LoadProprietaireByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
