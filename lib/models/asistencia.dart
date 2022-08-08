import 'dart:convert';

import 'package:preceptor_app/models/tutor.dart';

import 'alumno.dart';

class Asistencia {
  Asistencia({this.cicloLectivo, this.estado, this.fecha, this.alumno});

  final String? fecha;

  final int? cicloLectivo;
  final String? estado;
  final int? alumno;

  factory Asistencia.fromRawJson(String str) =>
      Asistencia.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Asistencia.fromJson(Map<String, dynamic> json) => Asistencia(
      estado: json["estado"] ?? '',
      cicloLectivo: json["cicloLectivo"] ?? 0,
      fecha: json["fecha"] ?? '',
      alumno: json["alumno"] ?? 0);

  Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "cicloLectivo": cicloLectivo,
        "alumno": alumno,
        "estado": estado
      };
}
