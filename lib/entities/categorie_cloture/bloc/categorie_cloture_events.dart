part of 'categorie_cloture_bloc.dart';

abstract class CategorieClotureEvent extends Equatable {
  const CategorieClotureEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitCategorieClotureList extends CategorieClotureEvent {}

class LibelleChanged extends CategorieClotureEvent {
  final String libelle;

  const LibelleChanged({required this.libelle});

  @override
  List<Object> get props => [libelle];
}
class PrixMetreCareChanged extends CategorieClotureEvent {
  final double prixMetreCare;

  const PrixMetreCareChanged({required this.prixMetreCare});

  @override
  List<Object> get props => [prixMetreCare];
}

class CategorieClotureFormSubmitted extends CategorieClotureEvent {}

class LoadCategorieClotureByIdForEdit extends CategorieClotureEvent {
  final int? id;

  const LoadCategorieClotureByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteCategorieClotureById extends CategorieClotureEvent {
  final int? id;

  const DeleteCategorieClotureById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadCategorieClotureByIdForView extends CategorieClotureEvent {
  final int? id;

  const LoadCategorieClotureByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
