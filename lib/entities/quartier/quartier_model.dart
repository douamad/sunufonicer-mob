import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../commune/commune_model.dart';

@jsonSerializable
class Quartier {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'code')
  final String? code;

  @JsonProperty(name: 'libelle')
  final String? libelle;

  @JsonProperty(name: 'communune')
  final Commune? communune;

 const Quartier (
     this.id,
        this.code,
        this.libelle,
        this.communune,
    );

@override
String toString() {
    return 'Quartier{'+
    'id: $id,' +
        'code: $code,' +
        'libelle: $libelle,' +
        'communune: $communune,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Quartier &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


