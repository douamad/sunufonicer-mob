part of 'refcadastrale_bloc.dart';

abstract class RefcadastraleEvent extends Equatable {
  const RefcadastraleEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitRefcadastraleList extends RefcadastraleEvent {}

class CodeSectionChanged extends RefcadastraleEvent {
  final String codeSection;

  const CodeSectionChanged({required this.codeSection});

  @override
  List<Object> get props => [codeSection];
}
class CodeParcelleChanged extends RefcadastraleEvent {
  final String codeParcelle;

  const CodeParcelleChanged({required this.codeParcelle});

  @override
  List<Object> get props => [codeParcelle];
}
class NicadChanged extends RefcadastraleEvent {
  final String nicad;

  const NicadChanged({required this.nicad});

  @override
  List<Object> get props => [nicad];
}
class SuperficiChanged extends RefcadastraleEvent {
  final double superfici;

  const SuperficiChanged({required this.superfici});

  @override
  List<Object> get props => [superfici];
}
class TitreMereChanged extends RefcadastraleEvent {
  final String titreMere;

  const TitreMereChanged({required this.titreMere});

  @override
  List<Object> get props => [titreMere];
}
class TitreCreeChanged extends RefcadastraleEvent {
  final String titreCree;

  const TitreCreeChanged({required this.titreCree});

  @override
  List<Object> get props => [titreCree];
}
class NumeroRequisitionChanged extends RefcadastraleEvent {
  final String numeroRequisition;

  const NumeroRequisitionChanged({required this.numeroRequisition});

  @override
  List<Object> get props => [numeroRequisition];
}
class DateBornageChanged extends RefcadastraleEvent {
  final DateTime dateBornage;

  const DateBornageChanged({required this.dateBornage});

  @override
  List<Object> get props => [dateBornage];
}

class RefcadastraleFormSubmitted extends RefcadastraleEvent {}

class LoadRefcadastraleByIdForEdit extends RefcadastraleEvent {
  final int? id;

  const LoadRefcadastraleByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteRefcadastraleById extends RefcadastraleEvent {
  final int? id;

  const DeleteRefcadastraleById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadRefcadastraleByIdForView extends RefcadastraleEvent {
  final int? id;

  const LoadRefcadastraleByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
