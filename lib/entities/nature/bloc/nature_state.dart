part of 'nature_bloc.dart';

enum NatureStatusUI {init, loading, error, done}
enum NatureDeleteStatus {ok, ko, none}

class NatureState extends Equatable {
  final List<Nature> natures;
  final Nature loadedNature;
  final bool editMode;
  final NatureDeleteStatus deleteStatus;
  final NatureStatusUI natureStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final CodeInput code;
  final LibelleInput libelle;


  NatureState({
    this.natures = const [],
    this.natureStatusUI = NatureStatusUI.init,
    this.loadedNature = const Nature(0,'','',),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = NatureDeleteStatus.none,
    this.code = const CodeInput.pure(),
    this.libelle = const LibelleInput.pure(),
  });

  NatureState copyWith({
    List<Nature>? natures,
    NatureStatusUI? natureStatusUI,
    bool? editMode,
    NatureDeleteStatus? deleteStatus,
    Nature? loadedNature,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    CodeInput? code,
    LibelleInput? libelle,
  }) {
    return NatureState(
      natures: natures ?? this.natures,
      natureStatusUI: natureStatusUI ?? this.natureStatusUI,
      loadedNature: loadedNature ?? this.loadedNature,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
    );
  }

  @override
  List<Object> get props => [natures, natureStatusUI,
     loadedNature, editMode, deleteStatus, formStatus, generalNotificationKey,
code,libelle,];

  @override
  bool get stringify => true;
}
