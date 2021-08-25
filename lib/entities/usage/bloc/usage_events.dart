part of 'usage_bloc.dart';

abstract class UsageEvent extends Equatable {
  const UsageEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitUsageList extends UsageEvent {}

class CodeChanged extends UsageEvent {
  final String code;

  const CodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}
class LibelleChanged extends UsageEvent {
  final String libelle;

  const LibelleChanged({required this.libelle});

  @override
  List<Object> get props => [libelle];
}

class UsageFormSubmitted extends UsageEvent {}

class LoadUsageByIdForEdit extends UsageEvent {
  final int? id;

  const LoadUsageByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteUsageById extends UsageEvent {
  final int? id;

  const DeleteUsageById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadUsageByIdForView extends UsageEvent {
  final int? id;

  const LoadUsageByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
