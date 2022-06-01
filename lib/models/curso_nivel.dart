import 'dart:convert';

class Nivel {
  Nivel({
    this.nivel,
    this.ciclo,
  });

  final int? nivel;
  final String? ciclo;

  factory Nivel.fromRawJson(String str) => Nivel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Nivel.fromJson(Map<String, dynamic> json) => Nivel(
        nivel: json["nivel"] ?? 0,
        ciclo: json["ciclo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "nivel": nivel,
        "ciclo": ciclo,
      };
}
