import 'dart:convert';

import 'package:preceptor_app/models/tutor.dart';

import 'asistencia.dart';

class Alumno {
  Alumno({this.apellido, this.nombre, this.tutor, this.asistencias});

  final String? apellido;
  final String? nombre;
  final Tutor? tutor;
  final List<Asistencia>? asistencias;

  factory Alumno.fromRawJson(String str) => Alumno.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Alumno.fromJson(Map<String, dynamic> json) => Alumno(
      apellido: json["apellido"] ?? '',
      nombre: json["nombre"] ?? '',
      tutor: Tutor.fromJson(
          json["tutor"] ?? Tutor(apellido: '', nombre: '', telefono: '')),
      asistencias: List<Asistencia>.from(
          json["asistencias"].map((x) => Asistencia.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "apellido": apellido,
        "nombre": nombre,
        "tutor": tutor!.toJson(),
        "asistencias": List<dynamic>.from(asistencias!.map((a) => a.toJson()))
      };
}
