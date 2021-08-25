part of 'commune_bloc.dart';

abstract class CommuneEvent extends Equatable {
  const CommuneEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitCommuneList extends CommuneEvent {}

class CodeChanged extends CommuneEvent {
  final String code;

  const CodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}
class LibelleChanged extends CommuneEvent {
  final String libelle;

  const LibelleChanged({required this.libelle});

  @override
  List<Object> get props => [libelle];
}

class CommuneFormSubmitted extends CommuneEvent {}

class LoadCommuneByIdForEdit extends CommuneEvent {
  final int? id;

  const LoadCommuneByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteCommuneById extends CommuneEvent {
  final int? id;

  const DeleteCommuneById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadCommuneByIdForView extends CommuneEvent {
  final int? id;

  const LoadCommuneByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
