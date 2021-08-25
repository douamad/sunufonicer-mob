part of 'representant_bloc.dart';

abstract class RepresentantEvent extends Equatable {
  const RepresentantEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitRepresentantList extends RepresentantEvent {}

class PrenomChanged extends RepresentantEvent {
  final String prenom;

  const PrenomChanged({required this.prenom});

  @override
  List<Object> get props => [prenom];
}
class NomChanged extends RepresentantEvent {
  final String nom;

  const NomChanged({required this.nom});

  @override
  List<Object> get props => [nom];
}
class ActifChanged extends RepresentantEvent {
  final bool actif;

  const ActifChanged({required this.actif});

  @override
  List<Object> get props => [actif];
}
class RaisonSocialChanged extends RepresentantEvent {
  final String raisonSocial;

  const RaisonSocialChanged({required this.raisonSocial});

  @override
  List<Object> get props => [raisonSocial];
}
class PersonneMoraleChanged extends RepresentantEvent {
  final bool personneMorale;

  const PersonneMoraleChanged({required this.personneMorale});

  @override
  List<Object> get props => [personneMorale];
}
class DateNaissChanged extends RepresentantEvent {
  final DateTime dateNaiss;

  const DateNaissChanged({required this.dateNaiss});

  @override
  List<Object> get props => [dateNaiss];
}
class LieuNaissanceChanged extends RepresentantEvent {
  final String lieuNaissance;

  const LieuNaissanceChanged({required this.lieuNaissance});

  @override
  List<Object> get props => [lieuNaissance];
}
class NumCNIChanged extends RepresentantEvent {
  final String numCNI;

  const NumCNIChanged({required this.numCNI});

  @override
  List<Object> get props => [numCNI];
}
class NineaChanged extends RepresentantEvent {
  final String ninea;

  const NineaChanged({required this.ninea});

  @override
  List<Object> get props => [ninea];
}
class AdresseChanged extends RepresentantEvent {
  final String adresse;

  const AdresseChanged({required this.adresse});

  @override
  List<Object> get props => [adresse];
}
class EmailChanged extends RepresentantEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}
class TelephoneChanged extends RepresentantEvent {
  final String telephone;

  const TelephoneChanged({required this.telephone});

  @override
  List<Object> get props => [telephone];
}
class Telephone2Changed extends RepresentantEvent {
  final String telephone2;

  const Telephone2Changed({required this.telephone2});

  @override
  List<Object> get props => [telephone2];
}
class Telephone3Changed extends RepresentantEvent {
  final String telephone3;

  const Telephone3Changed({required this.telephone3});

  @override
  List<Object> get props => [telephone3];
}
class AquisitionChanged extends RepresentantEvent {
  final String aquisition;

  const AquisitionChanged({required this.aquisition});

  @override
  List<Object> get props => [aquisition];
}
class StatutPersoneStructureChanged extends RepresentantEvent {
  final String statutPersoneStructure;

  const StatutPersoneStructureChanged({required this.statutPersoneStructure});

  @override
  List<Object> get props => [statutPersoneStructure];
}
class TypeStructureChanged extends RepresentantEvent {
  final TypeStructure typeStructure;

  const TypeStructureChanged({required this.typeStructure});

  @override
  List<Object> get props => [typeStructure];
}

class RepresentantFormSubmitted extends RepresentantEvent {}

class LoadRepresentantByIdForEdit extends RepresentantEvent {
  final int? id;

  const LoadRepresentantByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteRepresentantById extends RepresentantEvent {
  final int? id;

  const DeleteRepresentantById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadRepresentantByIdForView extends RepresentantEvent {
  final int? id;

  const LoadRepresentantByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
