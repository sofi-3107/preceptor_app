import 'dart:convert';

import 'curso_nivel.dart';

class Curso {
  Curso({
    this.id,
    this.division,
    this.turno,
    this.nivel,
  });

  final int? id;
  final int? division;
  final String? turno;
  final Nivel? nivel;

  factory Curso.fromRawJson(String str) => Curso.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        id: json["id"] ?? 0,
        division: json["division"] ?? 0,
        turno: json["turno"] ?? '',
        nivel: Nivel.fromJson(json["nivel"]),
      );

  Map<String, dynamic> toJson() => {
        "division": division,
        "turno": turno,
        "nivel": nivel!.toJson(),
      };
}
