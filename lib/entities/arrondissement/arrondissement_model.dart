import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../departement/departement_model.dart';

@jsonSerializable
class Arrondissement {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'code')
  final String? code;

  @JsonProperty(name: 'libelle')
  final String? libelle;

  @JsonProperty(name: 'departement')
  final Departement? departement;

 const Arrondissement (
     this.id,
        this.code,
        this.libelle,
        this.departement,
    );

@override
String toString() {
    return 'Arrondissement{'+
    'id: $id,' +
        'code: $code,' +
        'libelle: $libelle,' +
        'departement: $departement,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Arrondissement &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


