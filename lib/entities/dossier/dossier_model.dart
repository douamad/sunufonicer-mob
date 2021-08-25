import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../lotissement/lotissement_model.dart';
import '../nature/nature_model.dart';
import '../activite/activite_model.dart';
import '../usage/usage_model.dart';
import '../proprietaire/proprietaire_model.dart';
import '../ref_parcelaire/ref_parcelaire_model.dart';
import '../refcadastrale/refcadastrale_model.dart';

@jsonSerializable
class Dossier {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'numero')
  final String? numero;

  @JsonProperty(name: 'montantLoyer')
  final double? montantLoyer;

  @JsonProperty(name: 'superficieBatie')
  final double? superficieBatie;

  @JsonProperty(name: 'coeffCorrectifBatie')
  final double? coeffCorrectifBatie;

  @JsonProperty(name: 'valeurBatie')
  final double? valeurBatie;

  @JsonProperty(name: 'lineaireCloture')
  final double? lineaireCloture;

  @JsonProperty(name: 'coeffCloture')
  final double? coeffCloture;

  @JsonProperty(name: 'valeurCloture')
  final double? valeurCloture;

  @JsonProperty(name: 'amenagementSpaciaux')
  final String? amenagementSpaciaux;

  @JsonProperty(name: 'valeurAmenagement')
  final double? valeurAmenagement;

  @JsonProperty(name: 'valeurVenale')
  final double? valeurVenale;

  @JsonProperty(name: 'valeurLocativ')
  final String? valeurLocativ;

  @JsonProperty(name: 'dossier')
  final Lotissement? dossier;

  @JsonProperty(name: 'nature')
  final Nature? nature;

  @JsonProperty(name: 'activite')
  final Activite? activite;

  @JsonProperty(name: 'usage')
  final Usage? usage;

  @JsonProperty(name: 'proprietaire')
  final Proprietaire? proprietaire;

  @JsonProperty(name: 'refParcelaire')
  final RefParcelaire? refParcelaire;

  @JsonProperty(name: 'refcadastrale')
  final Refcadastrale? refcadastrale;

 const Dossier (
     this.id,
        this.numero,
        this.montantLoyer,
        this.superficieBatie,
        this.coeffCorrectifBatie,
        this.valeurBatie,
        this.lineaireCloture,
        this.coeffCloture,
        this.valeurCloture,
        this.amenagementSpaciaux,
        this.valeurAmenagement,
        this.valeurVenale,
        this.valeurLocativ,
        this.dossier,
        this.nature,
        this.activite,
        this.usage,
        this.proprietaire,
        this.refParcelaire,
        this.refcadastrale,
    );

@override
String toString() {
    return 'Dossier{'+
    'id: $id,' +
        'numero: $numero,' +
        'montantLoyer: $montantLoyer,' +
        'superficieBatie: $superficieBatie,' +
        'coeffCorrectifBatie: $coeffCorrectifBatie,' +
        'valeurBatie: $valeurBatie,' +
        'lineaireCloture: $lineaireCloture,' +
        'coeffCloture: $coeffCloture,' +
        'valeurCloture: $valeurCloture,' +
        'amenagementSpaciaux: $amenagementSpaciaux,' +
        'valeurAmenagement: $valeurAmenagement,' +
        'valeurVenale: $valeurVenale,' +
        'valeurLocativ: $valeurLocativ,' +
        'dossier: $dossier,' +
        'nature: $nature,' +
        'activite: $activite,' +
        'usage: $usage,' +
        'proprietaire: $proprietaire,' +
        'refParcelaire: $refParcelaire,' +
        'refcadastrale: $refcadastrale,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Dossier &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


