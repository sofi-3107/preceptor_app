import 'dart:convert';

class CondicionMateria {
  CondicionMateria(
      {required this.nombreMateria, this.aprobados, this.desaprobados});

  int? aprobados;
  int? desaprobados;
  String nombreMateria;

  factory CondicionMateria.fromRawJson(String str) =>
      CondicionMateria.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CondicionMateria.fromJson(Map<String, dynamic> json) =>
      CondicionMateria(
        nombreMateria: json["materia"] ?? '',
        aprobados: int.parse(json["aprobados"]),
        desaprobados: int.parse(json["desaprobados"]),
      );

  Map<String, dynamic> toJson() => {};
}
