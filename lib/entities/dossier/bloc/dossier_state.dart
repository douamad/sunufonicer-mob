part of 'dossier_bloc.dart';

enum DossierStatusUI {init, loading, error, done}
enum DossierDeleteStatus {ok, ko, none}

class DossierState extends Equatable {
  final List<Dossier> dossiers;
  final Dossier loadedDossier;
  final bool editMode;
  final DossierDeleteStatus deleteStatus;
  final DossierStatusUI dossierStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final NumeroInput numero;
  final MontantLoyerInput montantLoyer;
  final SuperficieBatieInput superficieBatie;
  final CoeffCorrectifBatieInput coeffCorrectifBatie;
  final ValeurBatieInput valeurBatie;
  final LineaireClotureInput lineaireCloture;
  final CoeffClotureInput coeffCloture;
  final ValeurClotureInput valeurCloture;
  final AmenagementSpaciauxInput amenagementSpaciaux;
  final ValeurAmenagementInput valeurAmenagement;
  final ValeurVenaleInput valeurVenale;
  final ValeurLocativInput valeurLocativ;


  DossierState({
    this.dossiers = const [],
    this.dossierStatusUI = DossierStatusUI.init,
    this.loadedDossier = const Dossier(0,'',0.0,0.0,0.0,0.0,0.0,0.0,0.0,'',0.0,0.0,'',null,null,null,null,null,null,null,),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = DossierDeleteStatus.none,
    this.numero = const NumeroInput.pure(),
    this.montantLoyer = const MontantLoyerInput.pure(),
    this.superficieBatie = const SuperficieBatieInput.pure(),
    this.coeffCorrectifBatie = const CoeffCorrectifBatieInput.pure(),
    this.valeurBatie = const ValeurBatieInput.pure(),
    this.lineaireCloture = const LineaireClotureInput.pure(),
    this.coeffCloture = const CoeffClotureInput.pure(),
    this.valeurCloture = const ValeurClotureInput.pure(),
    this.amenagementSpaciaux = const AmenagementSpaciauxInput.pure(),
    this.valeurAmenagement = const ValeurAmenagementInput.pure(),
    this.valeurVenale = const ValeurVenaleInput.pure(),
    this.valeurLocativ = const ValeurLocativInput.pure(),
  });

  DossierState copyWith({
    List<Dossier>? dossiers,
    DossierStatusUI? dossierStatusUI,
    bool? editMode,
    DossierDeleteStatus? deleteStatus,
    Dossier? loadedDossier,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    NumeroInput? numero,
    MontantLoyerInput? montantLoyer,
    SuperficieBatieInput? superficieBatie,
    CoeffCorrectifBatieInput? coeffCorrectifBatie,
    ValeurBatieInput? valeurBatie,
    LineaireClotureInput? lineaireCloture,
    CoeffClotureInput? coeffCloture,
    ValeurClotureInput? valeurCloture,
    AmenagementSpaciauxInput? amenagementSpaciaux,
    ValeurAmenagementInput? valeurAmenagement,
    ValeurVenaleInput? valeurVenale,
    ValeurLocativInput? valeurLocativ,
  }) {
    return DossierState(
      dossiers: dossiers ?? this.dossiers,
      dossierStatusUI: dossierStatusUI ?? this.dossierStatusUI,
      loadedDossier: loadedDossier ?? this.loadedDossier,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      numero: numero ?? this.numero,
      montantLoyer: montantLoyer ?? this.montantLoyer,
      superficieBatie: superficieBatie ?? this.superficieBatie,
      coeffCorrectifBatie: coeffCorrectifBatie ?? this.coeffCorrectifBatie,
      valeurBatie: valeurBatie ?? this.valeurBatie,
      lineaireCloture: lineaireCloture ?? this.lineaireCloture,
      coeffCloture: coeffCloture ?? this.coeffCloture,
      valeurCloture: valeurCloture ?? this.valeurCloture,
      amenagementSpaciaux: amenagementSpaciaux ?? this.amenagementSpaciaux,
      valeurAmenagement: valeurAmenagement ?? this.valeurAmenagement,
      valeurVenale: valeurVenale ?? this.valeurVenale,
      valeurLocativ: valeurLocativ ?? this.valeurLocativ,
    );
  }

  @override
  List<Object> get props => [dossiers, dossierStatusUI,
     loadedDossier, editMode, deleteStatus, formStatus, generalNotificationKey,
numero,montantLoyer,superficieBatie,coeffCorrectifBatie,valeurBatie,lineaireCloture,coeffCloture,valeurCloture,amenagementSpaciaux,valeurAmenagement,valeurVenale,valeurLocativ,];

  @override
  bool get stringify => true;
}
