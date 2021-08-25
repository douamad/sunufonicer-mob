import 'package:dart_json_mapper/dart_json_mapper.dart';


@jsonSerializable
class RefParcelaire {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'numeroParcelle')
  final String? numeroParcelle;

  @JsonProperty(name: 'natureParcelle')
  final String? natureParcelle;

 const RefParcelaire (
     this.id,
        this.numeroParcelle,
        this.natureParcelle,
    );

@override
String toString() {
    return 'RefParcelaire{'+
    'id: $id,' +
        'numeroParcelle: $numeroParcelle,' +
        'natureParcelle: $natureParcelle,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is RefParcelaire &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


