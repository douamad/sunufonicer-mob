import 'package:dart_json_mapper/dart_json_mapper.dart';


@jsonSerializable
class Nature {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'code')
  final String? code;

  @JsonProperty(name: 'libelle')
  final String? libelle;

 const Nature (
     this.id,
        this.code,
        this.libelle,
    );

@override
String toString() {
    return 'Nature{'+
    'id: $id,' +
        'code: $code,' +
        'libelle: $libelle,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Nature &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


