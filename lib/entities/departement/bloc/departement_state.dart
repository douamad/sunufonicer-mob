part of 'departement_bloc.dart';

enum DepartementStatusUI {init, loading, error, done}
enum DepartementDeleteStatus {ok, ko, none}

class DepartementState extends Equatable {
  final List<Departement> departements;
  final Departement loadedDepartement;
  final bool editMode;
  final DepartementDeleteStatus deleteStatus;
  final DepartementStatusUI departementStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final CodeInput code;
  final LibelleInput libelle;


  DepartementState({
    this.departements = const [],
    this.departementStatusUI = DepartementStatusUI.init,
    this.loadedDepartement = const Departement(0,'','',null,),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = DepartementDeleteStatus.none,
    this.code = const CodeInput.pure(),
    this.libelle = const LibelleInput.pure(),
  });

  DepartementState copyWith({
    List<Departement>? departements,
    DepartementStatusUI? departementStatusUI,
    bool? editMode,
    DepartementDeleteStatus? deleteStatus,
    Departement? loadedDepartement,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    CodeInput? code,
    LibelleInput? libelle,
  }) {
    return DepartementState(
      departements: departements ?? this.departements,
      departementStatusUI: departementStatusUI ?? this.departementStatusUI,
      loadedDepartement: loadedDepartement ?? this.loadedDepartement,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
    );
  }

  @override
  List<Object> get props => [departements, departementStatusUI,
     loadedDepartement, editMode, deleteStatus, formStatus, generalNotificationKey,
code,libelle,];

  @override
  bool get stringify => true;
}
