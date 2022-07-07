import 'package:flutter/foundation.dart';
import 'package:preceptor_app/models/alumno.dart';
import 'package:preceptor_app/models/curso.dart';
import 'package:preceptor_app/services/httpservice.dart';

class PreceptorProvider extends ChangeNotifier {
  List<Alumno> alumnosCurso = [];
  HttpService service = HttpService();
  List<Curso> cursosPreceptor = [];
  final currentyear = DateTime.now().year;
  String selectedCantFaltasFilter = '';
  String selectedCursoFilter = '';
  int idCurso = 0;
  int cantidadFaltas = 0;
  List<String> telTutores = [];

//Getter y Setter para compartir el id del curso entre componentes
  getIdCurso() => idCurso;
  setIdCurso(id) {
    idCurso = id;
    notifyListeners();
  }

  getCantidadFaltas() => cantidadFaltas;

  setCantidadFaltas(cant) {
    cantidadFaltas = cant;
    notifyListeners();
  }

  getTelTutores() => telTutores;

  /**Retorna la lista de alumnos de un curso en particular */

  Future<List<Alumno>> getAlumnosCursoOfProvider(
    int curso,
  ) async {
    alumnosCurso.clear();
    await service
        .getAlumnosCurso(curso, currentyear)
        .then((value) => alumnosCurso = value);

    return alumnosCurso;
  }

  Future<List<Curso>> getCursosPreceptorOfProvider(int idPreceptor) async {
    await service
        .getCursosPreceptor(idPreceptor)
        .then((value) => cursosPreceptor = value);
    return cursosPreceptor;
  }

  setFilterCantidadFaltas(String faltas) {
    selectedCantFaltasFilter = faltas;

    notifyListeners();
  }

  getTelefonosTutores() {
    telTutores.clear();
    for (var a in alumnosCurso) {
      if (a.asistencias!.where((a) => a.estado == 'ausente').length >=
          getCantidadFaltas()) {
        telTutores.add(a.tutor!.telefono!);
      }
    }
    return telTutores;
  }
}
