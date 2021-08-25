import 'package:dart_json_mapper/dart_json_mapper.dart';


@jsonSerializable
class Refcadastrale {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'codeSection')
  final String? codeSection;

  @JsonProperty(name: 'codeParcelle')
  final String? codeParcelle;

  @JsonProperty(name: 'nicad')
  final String? nicad;

  @JsonProperty(name: 'superfici')
  final double? superfici;

  @JsonProperty(name: 'titreMere')
  final String? titreMere;

  @JsonProperty(name: 'titreCree')
  final String? titreCree;

  @JsonProperty(name: 'numeroRequisition')
  final String? numeroRequisition;

  @JsonProperty(name: 'dateBornage', converterParams: {'format': 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\''})
  final DateTime? dateBornage;

 const Refcadastrale (
     this.id,
        this.codeSection,
        this.codeParcelle,
        this.nicad,
        this.superfici,
        this.titreMere,
        this.titreCree,
        this.numeroRequisition,
        this.dateBornage,
    );

@override
String toString() {
    return 'Refcadastrale{'+
    'id: $id,' +
        'codeSection: $codeSection,' +
        'codeParcelle: $codeParcelle,' +
        'nicad: $nicad,' +
        'superfici: $superfici,' +
        'titreMere: $titreMere,' +
        'titreCree: $titreCree,' +
        'numeroRequisition: $numeroRequisition,' +
        'dateBornage: $dateBornage,' +
    '}';
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Refcadastrale &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


