import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../region/region_model.dart';

@jsonSerializable
class Departement {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'code')
  final String? code;

  @JsonProperty(name: 'libelle')
  final String? libelle;

  @JsonProperty(name: 'region')
  final Region? region;

 const Departement (
     this.id,
        this.code,
        this.libelle,
        this.region,
    );

@override
String toString() {
    return 'Departement{'+
    'id: $id,' +
        'code: $code,' +
        'libelle: $libelle,' +
        'region: $region,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Departement &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


