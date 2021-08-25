part of 'representant_bloc.dart';

enum RepresentantStatusUI {init, loading, error, done}
enum RepresentantDeleteStatus {ok, ko, none}

class RepresentantState extends Equatable {
  final List<Representant> representants;
  final Representant loadedRepresentant;
  final bool editMode;
  final RepresentantDeleteStatus deleteStatus;
  final RepresentantStatusUI representantStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final PrenomInput prenom;
  final NomInput nom;
  final ActifInput actif;
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


  RepresentantState({
    this.representants = const [],
    this.representantStatusUI = RepresentantStatusUI.init,
    this.loadedRepresentant = const Representant(0,'','',false,'',false,null,'','','','','','','','','','',null,null,),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = RepresentantDeleteStatus.none,
    this.prenom = const PrenomInput.pure(),
    this.nom = const NomInput.pure(),
    this.actif = const ActifInput.pure(),
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

  RepresentantState copyWith({
    List<Representant>? representants,
    RepresentantStatusUI? representantStatusUI,
    bool? editMode,
    RepresentantDeleteStatus? deleteStatus,
    Representant? loadedRepresentant,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    PrenomInput? prenom,
    NomInput? nom,
    ActifInput? actif,
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
    return RepresentantState(
      representants: representants ?? this.representants,
      representantStatusUI: representantStatusUI ?? this.representantStatusUI,
      loadedRepresentant: loadedRepresentant ?? this.loadedRepresentant,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      prenom: prenom ?? this.prenom,
      nom: nom ?? this.nom,
      actif: actif ?? this.actif,
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
  List<Object> get props => [representants, representantStatusUI,
     loadedRepresentant, editMode, deleteStatus, formStatus, generalNotificationKey,
prenom,nom,actif,raisonSocial,personneMorale,dateNaiss,lieuNaissance,numCNI,ninea,adresse,email,telephone,telephone2,telephone3,aquisition,statutPersoneStructure,typeStructure,];

  @override
  bool get stringify => true;
}
