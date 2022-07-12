import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:preceptor_app/custom_widgets/custom_appbar.dart';
import 'package:preceptor_app/custom_widgets/drawer_menu.dart';
import 'package:preceptor_app/models/condicion_materia.dart';
import 'package:preceptor_app/providers/grafico_provider.dart';
import 'package:provider/provider.dart';

class GraficoMaterias extends StatefulWidget {
  @override
  State<GraficoMaterias> createState() => _GraficoMateriasState();
}

class _GraficoMateriasState extends State<GraficoMaterias> {
  List<charts.Series<CondicionMateria, String>> seriesList = [];
  @override
  void initState() {
    super.initState();
  }

  barChart(seriesList) {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: false,
      barGroupingType: charts.BarGroupingType.stacked,
      barRendererDecorator: charts.BarLabelDecorator(
          outsideLabelStyleSpec: charts.TextStyleSpec(fontSize: 15),
          labelAnchor: charts.BarLabelAnchor.middle,
          insideLabelStyleSpec: charts.TextStyleSpec(
              fontSize: 20, color: charts.MaterialPalette.white)),
      behaviors: [
        charts.SeriesLegend(),
        charts.ChartTitle('Aprobados y Desaprobados por Materia'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GraficoProvider>(context);
    return Scaffold(
        appBar: const CustomAppbar(title: 'Grafico de Materias'),
        drawer: DrawerMenu(),
        body: FutureBuilder(
            future: provider
                .crearDatosGrafico()
                .then((value) => seriesList = value),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeArea(child: Card(child: barChart(seriesList)));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
