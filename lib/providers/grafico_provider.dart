import 'package:flutter/foundation.dart';
import 'package:preceptor_app/models/condicion_materia.dart';
import 'package:preceptor_app/services/httpservice.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraficoProvider extends ChangeNotifier {
  int selectedTrimestre = 1;
  setSelectedTrimestre(int trimestre) {
    print('new val: $trimestre');
    selectedTrimestre = 1;
    selectedTrimestre = trimestre;
    print('ultimoval: $selectedTrimestre');
    notifyListeners();
  }

  Future<List<charts.Series<CondicionMateria, String>>> crearDatosGrafico(
      int curso) async {
    List<CondicionMateria> aprobados = [];
    List<CondicionMateria> desaprobados = [];
    HttpService service = HttpService();
    final currentyear = DateTime.now().year;

    getSelectedTrimestre() => selectedTrimestre;

    print(
        'Curso que ingresa al providerGrafico: $curso, $currentyear,$selectedTrimestre');
    await service
        .getCantCondicionPorMateria(
            curso, currentyear, selectedTrimestre, 'aprobado')
        .then((data) {
      aprobados = data;
      print(' GraficoMateriasProvider Data: $data');
    });
    await service
        .getCantCondicionPorMateria(
            curso, currentyear, selectedTrimestre, 'desaprobado')
        .then((data) {
      print(' GraficoMateriasProvider Data Desparobados: ${data.length}');
      desaprobados = data;
    });

    return [
      charts.Series<CondicionMateria, String>(
          id: 'Aprobados',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (CondicionMateria cdnMateria, _) =>
              cdnMateria.nombreMateria,
          measureFn: (CondicionMateria cdnMateria, _) =>
              cdnMateria.aprobados ?? 0,
          data: aprobados,
          labelAccessorFn: (CondicionMateria cdnMateria, _) =>
              cdnMateria.aprobados.toString()),
      charts.Series<CondicionMateria, String>(
          id: 'Desaprobados',
          colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
          domainFn: (CondicionMateria cdnMateria, _) =>
              cdnMateria.nombreMateria,
          measureFn: (CondicionMateria cdnMateria, _) =>
              cdnMateria.desaprobados ?? 0,
          data: desaprobados,
          labelAccessorFn: (CondicionMateria cdnMateria, _) =>
              cdnMateria.desaprobados.toString()),
    ];
  }
}
