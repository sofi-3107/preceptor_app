import 'dart:convert';

class Nota {
  Nota({
    this.trimestre,
    this.condicionMateria,
    this.curso,
    this.materia,
  });

  final int? trimestre;
  final String? condicionMateria;
  final int? curso;
  final int? materia;

  factory Nota.fromRawJson(String str) => Nota.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Nota.fromJson(Map<String, dynamic> json) => Nota(
        trimestre: json["trimestre"] == null ? null : json["trimestre"],
        condicionMateria:
            json["condicionMateria"] ? null : json["condicionMateria"],
        curso: json["curso"] == null ? null : json["curso"]["id"],
        materia: json["materia"] == null ? null : json["materia"]["id"],
      );

  Map<String, dynamic> toJson() => {
        "trimestre": trimestre == null ? null : trimestre,
        "condicionMateria": condicionMateria == null ? null : condicionMateria,
        "curso": curso == null ? null : curso,
        "materia": materia == null ? null : materia,
      };
}
