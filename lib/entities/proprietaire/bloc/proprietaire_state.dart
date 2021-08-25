part of 'proprietaire_bloc.dart';

enum ProprietaireStatusUI {init, loading, error, done}
enum ProprietaireDeleteStatus {ok, ko, none}

class ProprietaireState extends Equatable {
  final List<Proprietaire> proprietaires;
  final Proprietaire loadedProprietaire;
  final bool editMode;
  final ProprietaireDeleteStatus deleteStatus;
  final ProprietaireStatusUI proprietaireStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final PrenomInput prenom;
  final NomInput nom;
  final SituationInput situation;
  final RaisonSocialInput raisonSocial;
  final PersonneMoraleInput personneMorale;
  final DateNaissInput dateNaiss;
  final LieuNaissanceInput lieuNaissance;
  final NumCNIInput numCNI;
  final NineaInput ninea;
  final AdresseInput adresse;
  final EmailInput email;
  final TelephoneInput telephone;
  final Telephone2Input telephone2;
  final Telephone3Input telephone3;
  final AquisitionInput aquisition;
  final StatutPersoneStructureInput statutPersoneStructure;
  final TypeStructureInput typeStructure;


  ProprietaireState({
    this.proprietaires = const [],
    this.proprietaireStatusUI = ProprietaireStatusUI.init,
    this.loadedProprietaire = const Proprietaire(0,'','',null,'',false,null,'','','','','','','','','','',null,),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = ProprietaireDeleteStatus.none,
    this.prenom = const PrenomInput.pure(),
    this.nom = const NomInput.pure(),
    this.situation = const SituationInput.pure(),
    this.raisonSocial = const RaisonSocialInput.pure(),
    this.personneMorale = const PersonneMoraleInput.pure(),
    this.dateNaiss = const DateNaissInput.pure(),
    this.lieuNaissance = const LieuNaissanceInput.pure(),
    this.numCNI = const NumCNIInput.pure(),
    this.ninea = const NineaInput.pure(),
    this.adresse = const AdresseInput.pure(),
    this.email = const EmailInput.pure(),
    this.telephone = const TelephoneInput.pure(),
    this.telephone2 = const Telephone2Input.pure(),
    this.telephone3 = const Telephone3Input.pure(),
    this.aquisition = const AquisitionInput.pure(),
    this.statutPersoneStructure = const StatutPersoneStructureInput.pure(),
    this.typeStructure = const TypeStructureInput.pure(),
  });

  ProprietaireState copyWith({
    List<Proprietaire>? proprietaires,
    ProprietaireStatusUI? proprietaireStatusUI,
    bool? editMode,
    ProprietaireDeleteStatus? deleteStatus,
    Proprietaire? loadedProprietaire,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    PrenomInput? prenom,
    NomInput? nom,
    SituationInput? situation,
    RaisonSocialInput? raisonSocial,
    PersonneMoraleInput? personneMorale,
    DateNaissInput? dateNaiss,
    LieuNaissanceInput? lieuNaissance,
    NumCNIInput? numCNI,
    NineaInput? ninea,
    AdresseInput? adresse,
    EmailInput? email,
    TelephoneInput? telephone,
    Telephone2Input? telephone2,
    Telephone3Input? telephone3,
    AquisitionInput? aquisition,
    StatutPersoneStructureInput? statutPersoneStructure,
    TypeStructureInput? typeStructure,
  }) {
    return ProprietaireState(
      proprietaires: proprietaires ?? this.proprietaires,
      proprietaireStatusUI: proprietaireStatusUI ?? this.proprietaireStatusUI,
      loadedProprietaire: loadedProprietaire ?? this.loadedProprietaire,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      prenom: prenom ?? this.prenom,
      nom: nom ?? this.nom,
      situation: situation ?? this.situation,
      raisonSocial: raisonSocial ?? this.raisonSocial,
      personneMorale: personneMorale ?? this.personneMorale,
      dateNaiss: dateNaiss ?? this.dateNaiss,
      lieuNaissance: lieuNaissance ?? this.lieuNaissance,
      numCNI: numCNI ?? this.numCNI,
      ninea: ninea ?? this.ninea,
      adresse: adresse ?? this.adresse,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      telephone2: telephone2 ?? this.telephone2,
      telephone3: telephone3 ?? this.telephone3,
      aquisition: aquisition ?? this.aquisition,
      statutPersoneStructure: statutPersoneStructure ?? this.statutPersoneStructure,
      typeStructure: typeStructure ?? this.typeStructure,
    );
  }

  @override
  List<Object> get props => [proprietaires, proprietaireStatusUI,
     loadedProprietaire, editMode, deleteStatus, formStatus, generalNotificationKey,
prenom,nom,situation,raisonSocial,personneMorale,dateNaiss,lieuNaissance,numCNI,ninea,adresse,email,telephone,telephone2,telephone3,aquisition,statutPersoneStructure,typeStructure,];

  @override
  bool get stringify => true;
}
