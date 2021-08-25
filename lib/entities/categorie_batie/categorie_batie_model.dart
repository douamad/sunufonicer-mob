import 'dart:ffi';

import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../dossier/dossier_model.dart';

@jsonSerializable
class CategorieBatie {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'libelle')
  final String? libelle;

  @JsonProperty(name: 'prixMetreCare')
  final double? prixMetreCare;

  @JsonProperty(name: 'dossier')
  final Dossier? dossier;

 const CategorieBatie (
     this.id,
        this.libelle,
        this.prixMetreCare,
        this.dossier,
    );

@override
String toString() {
    return 'CategorieBatie{'+
    'id: $id,' +
        'libelle: $libelle,' +
        'prixMetreCare: $prixMetreCare,' +
        'dossier: $dossier,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is CategorieBatie &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


