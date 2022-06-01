import 'dart:convert';

import 'package:preceptor_app/models/tutor.dart';

class Alumno {
  Alumno({
    this.apellido,
    this.nombre,
    this.tutor,
  });

  final String? apellido;
  final String? nombre;
  final Tutor? tutor;

  factory Alumno.fromRawJson(String str) => Alumno.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Alumno.fromJson(Map<String, dynamic> json) => Alumno(
        apellido: json["apellido"] ?? '',
        nombre: json["nombre"] ?? '',
        tutor: Tutor.fromJson(
            json["tutor"] ?? Tutor(apellido: '', nombre: '', telefono: '')),
      );

  Map<String, dynamic> toJson() => {
        "apellido": apellido,
        "nombre": nombre,
        "tutor": tutor!.toJson(),
      };
}
