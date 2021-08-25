part of 'activite_bloc.dart';

abstract class ActiviteEvent extends Equatable {
  const ActiviteEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitActiviteList extends ActiviteEvent {}

class CodeChanged extends ActiviteEvent {
  final String code;

  const CodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}
class LibelleChanged extends ActiviteEvent {
  final String libelle;

  const LibelleChanged({required this.libelle});

  @override
  List<Object> get props => [libelle];
}

class ActiviteFormSubmitted extends ActiviteEvent {}

class LoadActiviteByIdForEdit extends ActiviteEvent {
  final int? id;

  const LoadActiviteByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteActiviteById extends ActiviteEvent {
  final int? id;

  const DeleteActiviteById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadActiviteByIdForView extends ActiviteEvent {
  final int? id;

  const LoadActiviteByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
