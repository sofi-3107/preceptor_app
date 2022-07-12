import 'package:flutter/foundation.dart';
import 'package:preceptor_app/models/condicion_materia.dart';
import 'package:preceptor_app/services/httpservice.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraficoProvider extends ChangeNotifier {
  Future<List<charts.Series<CondicionMateria, String>>>
      crearDatosGrafico() async {
    List<CondicionMateria> aprobados = [];
    List<CondicionMateria> desaprobados = [];
    HttpService service = HttpService();

    await service
        .getCantCondicionPorMateria(5, 2022, 1, 'aprobado')
        .then((data) {
      aprobados = data;
      print(' GraficoMateriasProvider Data: $data');
    });
    await service
        .getCantCondicionPorMateria(5, 2022, 1, 'desaprobado')
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
        domainFn: (CondicionMateria cdnMateria, _) => cdnMateria.nombreMateria,
        measureFn: (CondicionMateria cdnMateria, _) =>
            cdnMateria.desaprobados ?? 0,
        data: desaprobados,
      )
    ];
  }
}
