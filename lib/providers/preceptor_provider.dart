import 'package:flutter/foundation.dart';
import 'package:preceptor_app/models/alumno.dart';
import 'package:preceptor_app/models/curso.dart';
import 'package:preceptor_app/services/httpservice.dart';
import 'package:intl/intl.dart';

class PreceptorProvider extends ChangeNotifier {
  List<Alumno> alumnosCurso = [];
  HttpService service = HttpService();
  List<Curso> cursosPreceptor = [];
  Map<String, int> idCursos = {'1': 1, '2': 2};
  final currentyear = DateTime.now().year;
  String selectedCantFaltasFilter = '';
  String selectedCursoFilter = '';

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
    _fillMapWithIds();
    return cursosPreceptor;
  }

  _fillMapWithIds() {
    if (cursosPreceptor.length > 0) {
      cursosPreceptor.forEach((Curso m) {
        String key =
            '${m.nivel!.nivel}º ${m.division}º C${m.nivel!.ciclo![0]} T${m.turno![0]}';
        idCursos[key] = m.id!;
      });
      notifyListeners();
      idCursos.forEach((key, value) {
        print('key: $key value:$value');
      });
    }
  }

  setFilterCantidadFaltas(String faltas) {
    selectedCantFaltasFilter = faltas;

    notifyListeners();
  }

  setFilterCurso(String curso) {
    selectedCursoFilter = curso;

    notifyListeners();
  }
}
