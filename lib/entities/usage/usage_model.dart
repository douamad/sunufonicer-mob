import 'package:dart_json_mapper/dart_json_mapper.dart';


@jsonSerializable
class Usage {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'code')
  final String? code;

  @JsonProperty(name: 'libelle')
  final String? libelle;

 const Usage (
     this.id,
        this.code,
        this.libelle,
    );

@override
String toString() {
    return 'Usage{'+
    'id: $id,' +
        'code: $code,' +
        'libelle: $libelle,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Usage &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


