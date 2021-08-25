part of 'arrondissement_bloc.dart';

enum ArrondissementStatusUI {init, loading, error, done}
enum ArrondissementDeleteStatus {ok, ko, none}

class ArrondissementState extends Equatable {
  final List<Arrondissement> arrondissements;
  final Arrondissement loadedArrondissement;
  final bool editMode;
  final ArrondissementDeleteStatus deleteStatus;
  final ArrondissementStatusUI arrondissementStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final CodeInput code;
  final LibelleInput libelle;


  ArrondissementState({
    this.arrondissements = const [],
    this.arrondissementStatusUI = ArrondissementStatusUI.init,
    this.loadedArrondissement = const Arrondissement(0,'','',null,),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = ArrondissementDeleteStatus.none,
    this.code = const CodeInput.pure(),
    this.libelle = const LibelleInput.pure(),
  });

  ArrondissementState copyWith({
    List<Arrondissement>? arrondissements,
    ArrondissementStatusUI? arrondissementStatusUI,
    bool? editMode,
    ArrondissementDeleteStatus? deleteStatus,
    Arrondissement? loadedArrondissement,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    CodeInput? code,
    LibelleInput? libelle,
  }) {
    return ArrondissementState(
      arrondissements: arrondissements ?? this.arrondissements,
      arrondissementStatusUI: arrondissementStatusUI ?? this.arrondissementStatusUI,
      loadedArrondissement: loadedArrondissement ?? this.loadedArrondissement,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
    );
  }

  @override
  List<Object> get props => [arrondissements, arrondissementStatusUI,
     loadedArrondissement, editMode, deleteStatus, formStatus, generalNotificationKey,
code,libelle,];

  @override
  bool get stringify => true;
}
