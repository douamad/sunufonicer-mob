part of 'refcadastrale_bloc.dart';

enum RefcadastraleStatusUI {init, loading, error, done}
enum RefcadastraleDeleteStatus {ok, ko, none}

class RefcadastraleState extends Equatable {
  final List<Refcadastrale> refcadastrales;
  final Refcadastrale loadedRefcadastrale;
  final bool editMode;
  final RefcadastraleDeleteStatus deleteStatus;
  final RefcadastraleStatusUI refcadastraleStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final CodeSectionInput codeSection;
  final CodeParcelleInput codeParcelle;
  final NicadInput nicad;
  final SuperficiInput superfici;
  final TitreMereInput titreMere;
  final TitreCreeInput titreCree;
  final NumeroRequisitionInput numeroRequisition;
  final DateBornageInput dateBornage;


  RefcadastraleState({
    this.refcadastrales = const [],
    this.refcadastraleStatusUI = RefcadastraleStatusUI.init,
    this.loadedRefcadastrale = const Refcadastrale(0,'','','',0.0,'','','',null,),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = RefcadastraleDeleteStatus.none,
    this.codeSection = const CodeSectionInput.pure(),
    this.codeParcelle = const CodeParcelleInput.pure(),
    this.nicad = const NicadInput.pure(),
    this.superfici = const SuperficiInput.pure(),
    this.titreMere = const TitreMereInput.pure(),
    this.titreCree = const TitreCreeInput.pure(),
    this.numeroRequisition = const NumeroRequisitionInput.pure(),
    this.dateBornage = const DateBornageInput.pure(),
  });

  RefcadastraleState copyWith({
    List<Refcadastrale>? refcadastrales,
    RefcadastraleStatusUI? refcadastraleStatusUI,
    bool? editMode,
    RefcadastraleDeleteStatus? deleteStatus,
    Refcadastrale? loadedRefcadastrale,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    CodeSectionInput? codeSection,
    CodeParcelleInput? codeParcelle,
    NicadInput? nicad,
    SuperficiInput? superfici,
    TitreMereInput? titreMere,
    TitreCreeInput? titreCree,
    NumeroRequisitionInput? numeroRequisition,
    DateBornageInput? dateBornage,
  }) {
    return RefcadastraleState(
      refcadastrales: refcadastrales ?? this.refcadastrales,
      refcadastraleStatusUI: refcadastraleStatusUI ?? this.refcadastraleStatusUI,
      loadedRefcadastrale: loadedRefcadastrale ?? this.loadedRefcadastrale,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      codeSection: codeSection ?? this.codeSection,
      codeParcelle: codeParcelle ?? this.codeParcelle,
      nicad: nicad ?? this.nicad,
      superfici: superfici ?? this.superfici,
      titreMere: titreMere ?? this.titreMere,
      titreCree: titreCree ?? this.titreCree,
      numeroRequisition: numeroRequisition ?? this.numeroRequisition,
      dateBornage: dateBornage ?? this.dateBornage,
    );
  }

  @override
  List<Object> get props => [refcadastrales, refcadastraleStatusUI,
     loadedRefcadastrale, editMode, deleteStatus, formStatus, generalNotificationKey,
codeSection,codeParcelle,nicad,superfici,titreMere,titreCree,numeroRequisition,dateBornage,];

  @override
  bool get stringify => true;
}
