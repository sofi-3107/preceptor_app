import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:preceptor_app/custom_widgets/custom_appbar.dart';
import 'package:preceptor_app/custom_widgets/drawer_menu.dart';

class GraficoMaterias extends StatefulWidget {
  const GraficoMaterias({Key? key}) : super(key: key);

  @override
  State<GraficoMaterias> createState() => _GraficoMateriasState();
}

class _GraficoMateriasState extends State<GraficoMaterias> {
  late List<charts.Series<AprobadosPorMateria, String>> seriesList;

  static List<charts.Series<AprobadosPorMateria, String>> _crearDatosGrafico() {
    final aprobadosMaterias = [
      AprobadosPorMateria('matematica'),
      AprobadosPorMateria('inglés'),
      AprobadosPorMateria('geografía'),
      AprobadosPorMateria('historia'),
      AprobadosPorMateria('economía'),
      AprobadosPorMateria('ed. física'),
      AprobadosPorMateria('historia'),
      AprobadosPorMateria('economía'),
      AprobadosPorMateria('ed. física'),
    ];
    final desaprobadosMaterias = [
      AprobadosPorMateria('matematica'),
      AprobadosPorMateria('inglés'),
      AprobadosPorMateria('geografía'),
      AprobadosPorMateria('historia'),
      AprobadosPorMateria('economía'),
      AprobadosPorMateria('ed. física'),
      AprobadosPorMateria('historia'),
      AprobadosPorMateria('economía'),
      AprobadosPorMateria('ed. física'),
    ];
    return [
      charts.Series<AprobadosPorMateria, String>(
        id: 'Aprobados',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (AprobadosPorMateria materias, _) => materias.nombreMateria,
        measureFn: (AprobadosPorMateria alumnos, _) => alumnos.aprobados,
        data: aprobadosMaterias,
      ),
      charts.Series<AprobadosPorMateria, String>(
        id: 'Desaprobados',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (AprobadosPorMateria materias, _) => materias.nombreMateria,
        measureFn: (AprobadosPorMateria alumnos, _) => alumnos.desaprobados,
        data: desaprobadosMaterias,
      )
    ];
  }

  @override
  void initState() {
    super.initState();
    seriesList = _crearDatosGrafico();
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: false,
      // barGroupingType: charts.BarGroupingType.stacked,
      behaviors: [
        charts.SeriesLegend(),
        charts.ChartTitle('Aprobados y Desaprobados por Materia'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: 'Grafico de Materias'),
        drawer: DrawerMenu(),
        body: SafeArea(child: Card(child: barChart())));
  }
}

class AprobadosPorMateria {
  String nombreMateria = '';
  int aprobados = 0;
  int desaprobados = 0;
  var rand = Random();

  AprobadosPorMateria(this.nombreMateria) {
    aprobados = rand.nextInt(25);
    desaprobados = 25 - aprobados;
  }
}
