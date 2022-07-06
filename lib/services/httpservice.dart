import 'package:preceptor_app/models/alumno.dart';
import 'package:preceptor_app/models/curso.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  final rootUrl = 'http://192.168.0.179:3000/preceptor';
  final drawerCursosList = 'cursos';
  final alumnosCursoUrl = 'alumnos';

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
}
