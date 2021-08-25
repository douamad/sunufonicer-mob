part of 'lotissement_bloc.dart';

enum LotissementStatusUI {init, loading, error, done}
enum LotissementDeleteStatus {ok, ko, none}

class LotissementState extends Equatable {
  final List<Lotissement> lotissements;
  final Lotissement loadedLotissement;
  final bool editMode;
  final LotissementDeleteStatus deleteStatus;
  final LotissementStatusUI lotissementStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final CodeInput code;
  final LibelleInput libelle;


  LotissementState({
    this.lotissements = const [],
    this.lotissementStatusUI = LotissementStatusUI.init,
    this.loadedLotissement = const Lotissement(0,'','',null,),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = LotissementDeleteStatus.none,
    this.code = const CodeInput.pure(),
    this.libelle = const LibelleInput.pure(),
  });

  LotissementState copyWith({
    List<Lotissement>? lotissements,
    LotissementStatusUI? lotissementStatusUI,
    bool? editMode,
    LotissementDeleteStatus? deleteStatus,
    Lotissement? loadedLotissement,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    CodeInput? code,
    LibelleInput? libelle,
  }) {
    return LotissementState(
      lotissements: lotissements ?? this.lotissements,
      lotissementStatusUI: lotissementStatusUI ?? this.lotissementStatusUI,
      loadedLotissement: loadedLotissement ?? this.loadedLotissement,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
    );
  }

  @override
  List<Object> get props => [lotissements, lotissementStatusUI,
     loadedLotissement, editMode, deleteStatus, formStatus, generalNotificationKey,
code,libelle,];

  @override
  bool get stringify => true;
}
