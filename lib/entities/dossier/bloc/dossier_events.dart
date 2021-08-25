part of 'dossier_bloc.dart';

abstract class DossierEvent extends Equatable {
  const DossierEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitDossierList extends DossierEvent {}

class NumeroChanged extends DossierEvent {
  final String numero;

  const NumeroChanged({required this.numero});

  @override
  List<Object> get props => [numero];
}
class MontantLoyerChanged extends DossierEvent {
  final double montantLoyer;

  const MontantLoyerChanged({required this.montantLoyer});

  @override
  List<Object> get props => [montantLoyer];
}
class SuperficieBatieChanged extends DossierEvent {
  final double superficieBatie;

  const SuperficieBatieChanged({required this.superficieBatie});

  @override
  List<Object> get props => [superficieBatie];
}
class CoeffCorrectifBatieChanged extends DossierEvent {
  final double coeffCorrectifBatie;

  const CoeffCorrectifBatieChanged({required this.coeffCorrectifBatie});

  @override
  List<Object> get props => [coeffCorrectifBatie];
}
class ValeurBatieChanged extends DossierEvent {
  final double valeurBatie;

  const ValeurBatieChanged({required this.valeurBatie});

  @override
  List<Object> get props => [valeurBatie];
}
class LineaireClotureChanged extends DossierEvent {
  final double lineaireCloture;

  const LineaireClotureChanged({required this.lineaireCloture});

  @override
  List<Object> get props => [lineaireCloture];
}
class CoeffClotureChanged extends DossierEvent {
  final double coeffCloture;

  const CoeffClotureChanged({required this.coeffCloture});

  @override
  List<Object> get props => [coeffCloture];
}
class ValeurClotureChanged extends DossierEvent {
  final double valeurCloture;

  const ValeurClotureChanged({required this.valeurCloture});

  @override
  List<Object> get props => [valeurCloture];
}
class AmenagementSpaciauxChanged extends DossierEvent {
  final String amenagementSpaciaux;

  const AmenagementSpaciauxChanged({required this.amenagementSpaciaux});

  @override
  List<Object> get props => [amenagementSpaciaux];
}
class ValeurAmenagementChanged extends DossierEvent {
  final double valeurAmenagement;

  const ValeurAmenagementChanged({required this.valeurAmenagement});

  @override
  List<Object> get props => [valeurAmenagement];
}
class ValeurVenaleChanged extends DossierEvent {
  final double valeurVenale;

  const ValeurVenaleChanged({required this.valeurVenale});

  @override
  List<Object> get props => [valeurVenale];
}
class ValeurLocativChanged extends DossierEvent {
  final String valeurLocativ;

  const ValeurLocativChanged({required this.valeurLocativ});

  @override
  List<Object> get props => [valeurLocativ];
}

class DossierFormSubmitted extends DossierEvent {}

class LoadDossierByIdForEdit extends DossierEvent {
  final int? id;

  const LoadDossierByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteDossierById extends DossierEvent {
  final int? id;

  const DeleteDossierById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadDossierByIdForView extends DossierEvent {
  final int? id;

  const LoadDossierByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
