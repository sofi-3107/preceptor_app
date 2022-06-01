import 'dart:convert';

import 'package:preceptor_app/models/tutor.dart';

import 'alumno.dart';

class Asistencia {
  Asistencia(
      {this.cicloLectivo, this.estado, this.fecha, this.tardanza, this.alumno});

  final String? fecha;
  final int? tardanza;
  final int? cicloLectivo;
  final String? estado;
  final Alumno? alumno;

  factory Asistencia.fromRawJson(String str) =>
      Asistencia.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Asistencia.fromJson(Map<String, dynamic> json) => Asistencia(
      estado: json["estado"] ?? '',
      cicloLectivo: json["cicloLectivo"] ?? 0,
      fecha: json["fecha"] ?? '',
      tardanza: json["tardanza"] ?? 0,
      alumno: Alumno.fromJson(json["alumno"] ??
          Alumno(
              apellido: '',
              nombre: '',
              tutor: Tutor(apellido: '', nombre: '', telefono: ''))));

  Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "tardanza": tardanza,
        "cicloLectivo": cicloLectivo,
        "alumno": alumno!.toJson(),
        "estado": estado
      };
}
