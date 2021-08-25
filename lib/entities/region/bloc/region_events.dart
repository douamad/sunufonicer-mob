part of 'region_bloc.dart';

abstract class RegionEvent extends Equatable {
  const RegionEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitRegionList extends RegionEvent {}

class CodeChanged extends RegionEvent {
  final String code;

  const CodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}
class LibelleChanged extends RegionEvent {
  final String libelle;

  const LibelleChanged({required this.libelle});

  @override
  List<Object> get props => [libelle];
}

class RegionFormSubmitted extends RegionEvent {}

class LoadRegionByIdForEdit extends RegionEvent {
  final int? id;

  const LoadRegionByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteRegionById extends RegionEvent {
  final int? id;

  const DeleteRegionById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadRegionByIdForView extends RegionEvent {
  final int? id;

  const LoadRegionByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
