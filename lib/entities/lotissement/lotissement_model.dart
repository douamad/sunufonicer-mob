import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../quartier/quartier_model.dart';

@jsonSerializable
class Lotissement {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'code')
  final String? code;

  @JsonProperty(name: 'libelle')
  final String? libelle;

  @JsonProperty(name: 'quartier')
  final Quartier? quartier;

 const Lotissement (
     this.id,
        this.code,
        this.libelle,
        this.quartier,
    );

@override
String toString() {
    return 'Lotissement{'+
    'id: $id,' +
        'code: $code,' +
        'libelle: $libelle,' +
        'quartier: $quartier,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Lotissement &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


