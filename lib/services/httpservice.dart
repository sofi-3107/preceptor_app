import 'package:preceptor_app/models/alumno.dart';
import 'package:preceptor_app/models/asistencia.dart';
import 'package:preceptor_app/models/condicion_materia.dart';
import 'package:preceptor_app/models/curso.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:preceptor_app/models/nota.dart';

class HttpService {
  final rootUrl = 'http://192.168.100.4:3000/preceptor';
  final drawerCursosList = 'cursos';
  final alumnosCursoUrl = 'alumnos';
  final notasGrafico = 'notas';
  final asistenciaUrl = 'toma-asistencia';

  /**Obtiene la lista de cursos de un preceptor en particular */

  Future<List<Curso>> getCursosPreceptor(int id) async {
    List<Curso> cursos = [];
    final response =
        await http.get(Uri.parse('$rootUrl/$drawerCursosList/$id'));
    if (response.statusCode == 200) {
      final decodedResponse = await json.decode(response.body);
      for (var i = 0; i < decodedResponse.length; i++) {
        cursos.add(Curso.fromJson(decodedResponse[i]));
      }
    }
    return cursos;
  }

/**Obtiene la lista de alumnos de un curso en particular */
  Future<List<Alumno>> getAlumnosCurso(int curso, int cicloLectivo) async {
    List<Alumno> alumnosCurso = [];
    try {
      final response = await http
          .get(Uri.parse('$rootUrl/$alumnosCursoUrl/$curso/$cicloLectivo'));
      if (response.statusCode == 200) {
        final decodedResponse = await json.decode(response.body);
        for (var i = 0; i < decodedResponse.length; i++) {
          alumnosCurso.add(Alumno.fromJson(decodedResponse[i]));
        }
      }
    } on Exception catch (e) {
      print('Exception in getAlumnosCursos Http $e');
    }
    return alumnosCurso;
  }

/**Obtiene la cantidad de alumnos aprobados*/
  Future<List<CondicionMateria>> getCantCondicionPorMateria(
      int curso, int cicloLectivo, int trimestre, condicion) async {
    List<CondicionMateria> condicionMaterias = [];
    try {
      // print('$rootUrl/$notasGrafico/$curso/$cicloLectivo/$trimestre/$condicion');
      final response = await http.get(Uri.parse(
          '$rootUrl/$notasGrafico/$curso/$cicloLectivo/$trimestre/$condicion'));
      if (response.statusCode == 200) {
        final decodedResponse = await json.decode(response.body);
        print('condicion Grafico service:$condicion: $decodedResponse');
        for (var i = 0; i < decodedResponse.length; i++) {
          if (condicion == 'desaprobado') {
            condicionMaterias.add(CondicionMateria(
                nombreMateria: decodedResponse[i]["materia"],
                desaprobados: int.parse(decodedResponse[i]["desaprobados"])));
          } else {
            condicionMaterias.add(CondicionMateria(
                nombreMateria: decodedResponse[i]["materia"],
                aprobados: int.parse(decodedResponse[i]["aprobados"])));
          }
        }
      }

      return condicionMaterias;
    } catch (e) {
      print(
          'Error capturado en el service: $condicion:  $e  tamaño de lista retornada: ${condicionMaterias.length}');
      return condicionMaterias;
    }
  }

  guardarAsistencia(Asistencia asistencia) async {
    print('URL asistencia: $rootUrl/$asistenciaUrl');
    try {
      final response = await http.post(Uri.parse('$rootUrl/$asistenciaUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: json.encode(asistencia.toJson()));
      print('Asistencia: ${response.body} guardada');
      return response.body.toString();
    } catch (e) {
      print('Error en el servicio metodo GuardarAsistencia: $e');
    }
  }
}
