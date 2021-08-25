part of 'nature_bloc.dart';

abstract class NatureEvent extends Equatable {
  const NatureEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitNatureList extends NatureEvent {}

class CodeChanged extends NatureEvent {
  final String code;

  const CodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}
class LibelleChanged extends NatureEvent {
  final String libelle;

  const LibelleChanged({required this.libelle});

  @override
  List<Object> get props => [libelle];
}

class NatureFormSubmitted extends NatureEvent {}

class LoadNatureByIdForEdit extends NatureEvent {
  final int? id;

  const LoadNatureByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteNatureById extends NatureEvent {
  final int? id;

  const DeleteNatureById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadNatureByIdForView extends NatureEvent {
  final int? id;

  const LoadNatureByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
