import 'dart:convert';

class Tutor {
  Tutor({
    this.apellido,
    this.nombre,
    this.telefono,
  });

  final String? apellido;
  final String? nombre;
  final String? telefono;

  factory Tutor.fromRawJson(String str) => Tutor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tutor.fromJson(Map<String, dynamic> json) => Tutor(
        apellido: json["apellido"] ?? '',
        nombre: json["nombre"] ?? '',
        telefono: json["telefono"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "apellido": apellido,
        "nombre": nombre,
        "telefono": telefono,
      };
}
