import 'package:dart_json_mapper/dart_json_mapper.dart';


@jsonSerializable
class Proprietaire {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'prenom')
  final String? prenom;

  @JsonProperty(name: 'nom')
  final String? nom;

  @JsonProperty(name: 'situation')
  final SituationProprietaire? situation;

  @JsonProperty(name: 'raisonSocial')
  final String? raisonSocial;

  @JsonProperty(name: 'personneMorale')
  final bool? personneMorale;

  @JsonProperty(name: 'dateNaiss', converterParams: {'format': 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\''})
  final DateTime? dateNaiss;

  @JsonProperty(name: 'lieuNaissance')
  final String? lieuNaissance;

  @JsonProperty(name: 'numCNI')
  final String? numCNI;

  @JsonProperty(name: 'ninea')
  final String? ninea;

  @JsonProperty(name: 'adresse')
  final String? adresse;

  @JsonProperty(name: 'email')
  final String? email;

  @JsonProperty(name: 'telephone')
  final String? telephone;

  @JsonProperty(name: 'telephone2')
  final String? telephone2;

  @JsonProperty(name: 'telephone3')
  final String? telephone3;

  @JsonProperty(name: 'aquisition')
  final String? aquisition;

  @JsonProperty(name: 'statutPersoneStructure')
  final String? statutPersoneStructure;

  @JsonProperty(name: 'typeStructure')
  final TypeStructure? typeStructure;

 const Proprietaire (
     this.id,
        this.prenom,
        this.nom,
        this.situation,
        this.raisonSocial,
        this.personneMorale,
        this.dateNaiss,
        this.lieuNaissance,
        this.numCNI,
        this.ninea,
        this.adresse,
        this.email,
        this.telephone,
        this.telephone2,
        this.telephone3,
        this.aquisition,
        this.statutPersoneStructure,
        this.typeStructure,
    );

@override
String toString() {
    return 'Proprietaire{'+
    'id: $id,' +
        'prenom: $prenom,' +
        'nom: $nom,' +
        'situation: $situation,' +
        'raisonSocial: $raisonSocial,' +
        'personneMorale: $personneMorale,' +
        'dateNaiss: $dateNaiss,' +
        'lieuNaissance: $lieuNaissance,' +
        'numCNI: $numCNI,' +
        'ninea: $ninea,' +
        'adresse: $adresse,' +
        'email: $email,' +
        'telephone: $telephone,' +
        'telephone2: $telephone2,' +
        'telephone3: $telephone3,' +
        'aquisition: $aquisition,' +
        'statutPersoneStructure: $statutPersoneStructure,' +
        'typeStructure: $typeStructure,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Proprietaire &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


@jsonSerializable
enum SituationProprietaire {
    RESIDENT 
}@jsonSerializable
enum TypeStructure {
    ENTREPRISE_INDIVIDUEL ,
    SURL ,
    GIE ,
    SA ,
    SARL ,
    SNC ,
    SCS ,
    ASSOCIATION 
}