part of 'arrondissement_bloc.dart';

abstract class ArrondissementEvent extends Equatable {
  const ArrondissementEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitArrondissementList extends ArrondissementEvent {}

class CodeChanged extends ArrondissementEvent {
  final String code;

  const CodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}
class LibelleChanged extends ArrondissementEvent {
  final String libelle;

  const LibelleChanged({required this.libelle});

  @override
  List<Object> get props => [libelle];
}

class ArrondissementFormSubmitted extends ArrondissementEvent {}

class LoadArrondissementByIdForEdit extends ArrondissementEvent {
  final int? id;

  const LoadArrondissementByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteArrondissementById extends ArrondissementEvent {
  final int? id;

  const DeleteArrondissementById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadArrondissementByIdForView extends ArrondissementEvent {
  final int? id;

  const LoadArrondissementByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
