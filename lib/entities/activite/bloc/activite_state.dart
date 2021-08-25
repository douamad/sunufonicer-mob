part of 'activite_bloc.dart';

enum ActiviteStatusUI {init, loading, error, done}
enum ActiviteDeleteStatus {ok, ko, none}

class ActiviteState extends Equatable {
  final List<Activite> activites;
  final Activite loadedActivite;
  final bool editMode;
  final ActiviteDeleteStatus deleteStatus;
  final ActiviteStatusUI activiteStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final CodeInput code;
  final LibelleInput libelle;


  ActiviteState({
    this.activites = const [],
    this.activiteStatusUI = ActiviteStatusUI.init,
    this.loadedActivite = const Activite(0,'','',),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = ActiviteDeleteStatus.none,
    this.code = const CodeInput.pure(),
    this.libelle = const LibelleInput.pure(),
  });

  ActiviteState copyWith({
    List<Activite>? activites,
    ActiviteStatusUI? activiteStatusUI,
    bool? editMode,
    ActiviteDeleteStatus? deleteStatus,
    Activite? loadedActivite,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    CodeInput? code,
    LibelleInput? libelle,
  }) {
    return ActiviteState(
      activites: activites ?? this.activites,
      activiteStatusUI: activiteStatusUI ?? this.activiteStatusUI,
      loadedActivite: loadedActivite ?? this.loadedActivite,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
    );
  }

  @override
  List<Object> get props => [activites, activiteStatusUI,
     loadedActivite, editMode, deleteStatus, formStatus, generalNotificationKey,
code,libelle,];

  @override
  bool get stringify => true;
}
