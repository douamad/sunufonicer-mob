part of 'categorie_batie_bloc.dart';

abstract class CategorieBatieEvent extends Equatable {
  const CategorieBatieEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitCategorieBatieList extends CategorieBatieEvent {}

class LibelleChanged extends CategorieBatieEvent {
  final String libelle;

  const LibelleChanged({required this.libelle});

  @override
  List<Object> get props => [libelle];
}
class PrixMetreCareChanged extends CategorieBatieEvent {
  final double prixMetreCare;

  const PrixMetreCareChanged({required this.prixMetreCare});

  @override
  List<Object> get props => [prixMetreCare];
}

class CategorieBatieFormSubmitted extends CategorieBatieEvent {}

class LoadCategorieBatieByIdForEdit extends CategorieBatieEvent {
  final int? id;

  const LoadCategorieBatieByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteCategorieBatieById extends CategorieBatieEvent {
  final int? id;

  const DeleteCategorieBatieById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadCategorieBatieByIdForView extends CategorieBatieEvent {
  final int? id;

  const LoadCategorieBatieByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
