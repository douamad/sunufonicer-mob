part of 'ref_parcelaire_bloc.dart';

abstract class RefParcelaireEvent extends Equatable {
  const RefParcelaireEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitRefParcelaireList extends RefParcelaireEvent {}

class NumeroParcelleChanged extends RefParcelaireEvent {
  final String numeroParcelle;

  const NumeroParcelleChanged({required this.numeroParcelle});

  @override
  List<Object> get props => [numeroParcelle];
}
class NatureParcelleChanged extends RefParcelaireEvent {
  final String natureParcelle;

  const NatureParcelleChanged({required this.natureParcelle});

  @override
  List<Object> get props => [natureParcelle];
}

class RefParcelaireFormSubmitted extends RefParcelaireEvent {}

class LoadRefParcelaireByIdForEdit extends RefParcelaireEvent {
  final int? id;

  const LoadRefParcelaireByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteRefParcelaireById extends RefParcelaireEvent {
  final int? id;

  const DeleteRefParcelaireById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadRefParcelaireByIdForView extends RefParcelaireEvent {
  final int? id;

  const LoadRefParcelaireByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
