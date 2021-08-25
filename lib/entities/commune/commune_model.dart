import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../arrondissement/arrondissement_model.dart';

@jsonSerializable
class Commune {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'code')
  final String? code;

  @JsonProperty(name: 'libelle')
  final String? libelle;

  @JsonProperty(name: 'arrondissement')
  final Arrondissement? arrondissement;

 const Commune (
     this.id,
        this.code,
        this.libelle,
        this.arrondissement,
    );

@override
String toString() {
    return 'Commune{'+
    'id: $id,' +
        'code: $code,' +
        'libelle: $libelle,' +
        'arrondissement: $arrondissement,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Commune &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


