import 'package:dart_json_mapper/dart_json_mapper.dart';


@jsonSerializable
class Activite {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'code')
  final String? code;

  @JsonProperty(name: 'libelle')
  final String? libelle;

 const Activite (
     this.id,
        this.code,
        this.libelle,
    );

@override
String toString() {
    return 'Activite{'+
    'id: $id,' +
        'code: $code,' +
        'libelle: $libelle,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Activite &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


