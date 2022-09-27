import 'package:flutter/foundation.dart';
import 'package:preceptor_app/models/alumno.dart';
import 'package:preceptor_app/models/asistencia.dart';
import 'package:preceptor_app/models/condicion_materia.dart';
import 'package:preceptor_app/models/curso.dart';
import 'package:preceptor_app/services/httpservice.dart';

class PreceptorProvider extends ChangeNotifier {
  List<Alumno> alumnosCurso = [];
  HttpService service = HttpService();
  List<Curso> cursosPreceptor = [];
  final currentyear = DateTime.now().year;
  String selectedCantFaltasFilter = '';
  String selectedCursoFilter = '';
  Curso? selectedCurso;
  int cantidadFaltas = 0;
  int idCurso = 5;
  List<String> telTutores = [];
  String messageSMS = '';
  List<Asistencia> asistencias = [];
  List<CondicionMateria> aprobadosDesaprobados = [];
  
  /* String selectedEstadoAsistencia = 'ausente';

  getSelectedEstadoAsistencia() => selectedEstadoAsistencia;
  setSelectedEstadoAsistencia(String estado) {
    selectedEstadoAsistencia = estado;
    notifyListeners();
  }*/

//Getter y Setter para compartir el id del curso entre componentes
  getSelectedCurso() => selectedCurso;
  setSelectedCurso(Curso curso) {
    selectedCurso = curso;
    notifyListeners();
  }

  //El id del curso para el filtro_lista
  getIdCurso() => idCurso;
  setIdCurso(int id) {
    idCurso = 5;
    idCurso = id;
    notifyListeners();
  }

  getMessageSMS() => messageSMS;
  setMessageSMS(msg) {
    messageSMS = msg;
    //print(messageSMS);
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
        .getAlumnosCurso(curso, currentyear, DateTime.now().day,
            DateTime.now().month, DateTime.now().year)
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
        telTutores.add('+54${a.tutor!.telefono!}');
      }
    }
    return telTutores;
  }

  getDatosGraficos(int curso, int trimestre, String condicion) async {
    await service
        .getCantCondicionPorMateria(curso, currentyear, trimestre, condicion)
        .then((data) => aprobadosDesaprobados = data);
  }

  getDatosGrafico() {
    return aprobadosDesaprobados;
  }

  addAsistenciaFromAlumno(String estado, int idAlumno) {
    DateTime hoy = DateTime.now();
    asistencias.add(Asistencia(
      cicloLectivo: currentyear,
      estado: estado,
      fecha: '${hoy.day}/${hoy.month}/${hoy.year}',
      alumno: idAlumno,
    ));
  }

  Future<void> guardarAsistencias() async {
    for (var a in asistencias) {
      await service.guardarAsistencia(a);
    }
    asistencias.clear();
  }

  Future<String> obtenerNombrePreceptor(int id) async {
    Alumno preceptor = await service.obtenerNombre(id);
    return '${preceptor.nombre} ${preceptor.apellido}';
  }
}
