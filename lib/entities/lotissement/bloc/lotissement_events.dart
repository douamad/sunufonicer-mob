part of 'lotissement_bloc.dart';

abstract class LotissementEvent extends Equatable {
  const LotissementEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitLotissementList extends LotissementEvent {}

class CodeChanged extends LotissementEvent {
  final String code;

  const CodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}
class LibelleChanged extends LotissementEvent {
  final String libelle;

  const LibelleChanged({required this.libelle});

  @override
  List<Object> get props => [libelle];
}

class LotissementFormSubmitted extends LotissementEvent {}

class LoadLotissementByIdForEdit extends LotissementEvent {
  final int? id;

  const LoadLotissementByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteLotissementById extends LotissementEvent {
  final int? id;

  const DeleteLotissementById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadLotissementByIdForView extends LotissementEvent {
  final int? id;

  const LoadLotissementByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
