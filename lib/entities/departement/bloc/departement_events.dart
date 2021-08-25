part of 'departement_bloc.dart';

abstract class DepartementEvent extends Equatable {
  const DepartementEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitDepartementList extends DepartementEvent {}

class CodeChanged extends DepartementEvent {
  final String code;

  const CodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}
class LibelleChanged extends DepartementEvent {
  final String libelle;

  const LibelleChanged({required this.libelle});

  @override
  List<Object> get props => [libelle];
}

class DepartementFormSubmitted extends DepartementEvent {}

class LoadDepartementByIdForEdit extends DepartementEvent {
  final int? id;

  const LoadDepartementByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteDepartementById extends DepartementEvent {
  final int? id;

  const DeleteDepartementById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadDepartementByIdForView extends DepartementEvent {
  final int? id;

  const LoadDepartementByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
