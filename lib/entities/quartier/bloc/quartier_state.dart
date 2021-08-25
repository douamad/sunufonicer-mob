part of 'quartier_bloc.dart';

enum QuartierStatusUI {init, loading, error, done}
enum QuartierDeleteStatus {ok, ko, none}

class QuartierState extends Equatable {
  final List<Quartier> quartiers;
  final Quartier loadedQuartier;
  final bool editMode;
  final QuartierDeleteStatus deleteStatus;
  final QuartierStatusUI quartierStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final CodeInput code;
  final LibelleInput libelle;


  QuartierState({
    this.quartiers = const [],
    this.quartierStatusUI = QuartierStatusUI.init,
    this.loadedQuartier = const Quartier(0,'','',null,),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = QuartierDeleteStatus.none,
    this.code = const CodeInput.pure(),
    this.libelle = const LibelleInput.pure(),
  });

  QuartierState copyWith({
    List<Quartier>? quartiers,
    QuartierStatusUI? quartierStatusUI,
    bool? editMode,
    QuartierDeleteStatus? deleteStatus,
    Quartier? loadedQuartier,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    CodeInput? code,
    LibelleInput? libelle,
  }) {
    return QuartierState(
      quartiers: quartiers ?? this.quartiers,
      quartierStatusUI: quartierStatusUI ?? this.quartierStatusUI,
      loadedQuartier: loadedQuartier ?? this.loadedQuartier,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
    );
  }

  @override
  List<Object> get props => [quartiers, quartierStatusUI,
     loadedQuartier, editMode, deleteStatus, formStatus, generalNotificationKey,
code,libelle,];

  @override
  bool get stringify => true;
}
