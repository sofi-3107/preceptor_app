import 'package:flutter/foundation.dart';
import 'package:preceptor_app/models/alumno.dart';
import 'package:preceptor_app/models/curso.dart';
import 'package:preceptor_app/services/httpservice.dart';
import 'package:intl/intl.dart';

class PreceptorProvider extends ChangeNotifier {
  List<Alumno> alumnosCurso = [];
  HttpService service = HttpService();
  List<Curso> cursosPreceptor = [];
  final currentyear = DateTime.now().year;

  /**Retorna la lista de alumnos de un curso en particular */
  Future<List<Alumno>> getAlumnosCursoOfProvider(
    int curso,
  ) async {
    service
        .getAlumnosCurso(curso, currentyear)
        .then((value) => alumnosCurso = value);
    return alumnosCurso;
  }

  Future<List<Curso>> getCursosPreceptorOfProvider(int idPreceptor) async {
    service
        .getCursosPreceptor(idPreceptor)
        .then((value) => cursosPreceptor = value);
    return cursosPreceptor;
  }
}
