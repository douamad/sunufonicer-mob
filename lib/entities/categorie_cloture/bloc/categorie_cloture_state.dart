part of 'categorie_cloture_bloc.dart';

enum CategorieClotureStatusUI {init, loading, error, done}
enum CategorieClotureDeleteStatus {ok, ko, none}

class CategorieClotureState extends Equatable {
  final List<CategorieCloture> categorieClotures;
  final CategorieCloture loadedCategorieCloture;
  final bool editMode;
  final CategorieClotureDeleteStatus deleteStatus;
  final CategorieClotureStatusUI categorieClotureStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final LibelleInput libelle;
  final PrixMetreCareInput prixMetreCare;


  CategorieClotureState({
    this.categorieClotures = const [],
    this.categorieClotureStatusUI = CategorieClotureStatusUI.init,
    this.loadedCategorieCloture = const CategorieCloture(0,'',0.0,null,),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = CategorieClotureDeleteStatus.none,
    this.libelle = const LibelleInput.pure(),
    this.prixMetreCare = const PrixMetreCareInput.pure(),
  });

  CategorieClotureState copyWith({
    List<CategorieCloture>? categorieClotures,
    CategorieClotureStatusUI? categorieClotureStatusUI,
    bool? editMode,
    CategorieClotureDeleteStatus? deleteStatus,
    CategorieCloture? loadedCategorieCloture,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    LibelleInput? libelle,
    PrixMetreCareInput? prixMetreCare,
  }) {
    return CategorieClotureState(
      categorieClotures: categorieClotures ?? this.categorieClotures,
      categorieClotureStatusUI: categorieClotureStatusUI ?? this.categorieClotureStatusUI,
      loadedCategorieCloture: loadedCategorieCloture ?? this.loadedCategorieCloture,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      libelle: libelle ?? this.libelle,
      prixMetreCare: prixMetreCare ?? this.prixMetreCare,
    );
  }

  @override
  List<Object> get props => [categorieClotures, categorieClotureStatusUI,
     loadedCategorieCloture, editMode, deleteStatus, formStatus, generalNotificationKey,
libelle,prixMetreCare,];

  @override
  bool get stringify => true;
}
