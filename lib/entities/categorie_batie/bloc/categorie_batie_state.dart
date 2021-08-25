part of 'categorie_batie_bloc.dart';

enum CategorieBatieStatusUI {init, loading, error, done}
enum CategorieBatieDeleteStatus {ok, ko, none}

class CategorieBatieState extends Equatable {
  final List<CategorieBatie> categorieBaties;
  final CategorieBatie loadedCategorieBatie;
  final bool editMode;
  final CategorieBatieDeleteStatus deleteStatus;
  final CategorieBatieStatusUI categorieBatieStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final LibelleInput libelle;
  final PrixMetreCareInput prixMetreCare;


  CategorieBatieState({
    this.categorieBaties = const [],
    this.categorieBatieStatusUI = CategorieBatieStatusUI.init,
    this.loadedCategorieBatie = const CategorieBatie(0,'', null,null,),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = CategorieBatieDeleteStatus.none,
    this.libelle = const LibelleInput.pure(),
    this.prixMetreCare = const PrixMetreCareInput.pure(),
  });

  CategorieBatieState copyWith({
    List<CategorieBatie>? categorieBaties,
    CategorieBatieStatusUI? categorieBatieStatusUI,
    bool? editMode,
    CategorieBatieDeleteStatus? deleteStatus,
    CategorieBatie? loadedCategorieBatie,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    LibelleInput? libelle,
    PrixMetreCareInput? prixMetreCare,
  }) {
    return CategorieBatieState(
      categorieBaties: categorieBaties ?? this.categorieBaties,
      categorieBatieStatusUI: categorieBatieStatusUI ?? this.categorieBatieStatusUI,
      loadedCategorieBatie: loadedCategorieBatie ?? this.loadedCategorieBatie,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      libelle: libelle ?? this.libelle,
      prixMetreCare: prixMetreCare ?? this.prixMetreCare,
    );
  }

  @override
  List<Object> get props => [categorieBaties, categorieBatieStatusUI,
     loadedCategorieBatie, editMode, deleteStatus, formStatus, generalNotificationKey,
libelle,prixMetreCare,];

  @override
  bool get stringify => true;
}
