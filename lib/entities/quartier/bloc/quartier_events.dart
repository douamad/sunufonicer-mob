part of 'quartier_bloc.dart';

abstract class QuartierEvent extends Equatable {
  const QuartierEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitQuartierList extends QuartierEvent {}

class CodeChanged extends QuartierEvent {
  final String code;

  const CodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}
class LibelleChanged extends QuartierEvent {
  final String libelle;

  const LibelleChanged({required this.libelle});

  @override
  List<Object> get props => [libelle];
}

class QuartierFormSubmitted extends QuartierEvent {}

class LoadQuartierByIdForEdit extends QuartierEvent {
  final int? id;

  const LoadQuartierByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteQuartierById extends QuartierEvent {
  final int? id;

  const DeleteQuartierById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadQuartierByIdForView extends QuartierEvent {
  final int? id;

  const LoadQuartierByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
