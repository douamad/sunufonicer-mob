part of 'commune_bloc.dart';

enum CommuneStatusUI {init, loading, error, done}
enum CommuneDeleteStatus {ok, ko, none}

class CommuneState extends Equatable {
  final List<Commune> communes;
  final Commune loadedCommune;
  final bool editMode;
  final CommuneDeleteStatus deleteStatus;
  final CommuneStatusUI communeStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final CodeInput code;
  final LibelleInput libelle;


  CommuneState({
    this.communes = const [],
    this.communeStatusUI = CommuneStatusUI.init,
    this.loadedCommune = const Commune(0,'','',null,),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = CommuneDeleteStatus.none,
    this.code = const CodeInput.pure(),
    this.libelle = const LibelleInput.pure(),
  });

  CommuneState copyWith({
    List<Commune>? communes,
    CommuneStatusUI? communeStatusUI,
    bool? editMode,
    CommuneDeleteStatus? deleteStatus,
    Commune? loadedCommune,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    CodeInput? code,
    LibelleInput? libelle,
  }) {
    return CommuneState(
      communes: communes ?? this.communes,
      communeStatusUI: communeStatusUI ?? this.communeStatusUI,
      loadedCommune: loadedCommune ?? this.loadedCommune,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
    );
  }

  @override
  List<Object> get props => [communes, communeStatusUI,
     loadedCommune, editMode, deleteStatus, formStatus, generalNotificationKey,
code,libelle,];

  @override
  bool get stringify => true;
}
