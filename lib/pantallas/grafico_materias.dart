import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:preceptor_app/custom_widgets/custom_appbar.dart';
import 'package:preceptor_app/custom_widgets/drawer_menu.dart';
import 'package:preceptor_app/models/condicion_materia.dart';
import 'package:preceptor_app/providers/grafico_provider.dart';
import 'package:preceptor_app/providers/preceptor_provider.dart';
import 'package:provider/provider.dart';

class GraficoMaterias extends StatefulWidget {
  @override
  State<GraficoMaterias> createState() => _GraficoMateriasState();
}

class _GraficoMateriasState extends State<GraficoMaterias> {
  List<charts.Series<CondicionMateria, String>> seriesList = [];
  String valorLista = "1";

  @override
  void initState() {
    super.initState();
  }

  barChart(seriesList, orientation) {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: orientation == Orientation.landscape ? true : false,
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
    Orientation orientation = MediaQuery.of(context).orientation;
    final provider = Provider.of<GraficoProvider>(context);
    final providerCurso = Provider.of<PreceptorProvider>(context);
    return Scaffold(
        appBar: CustomAppbar(title: 'Grafico de Materias'),
        drawer: DrawerMenu(),
        body: FutureBuilder(
            future: provider
                .crearDatosGrafico(providerCurso.getIdCurso())
                .then((value) => seriesList = value),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var dropdownButton = DropdownButton(
                  value: valorLista,
                  alignment: Alignment.topRight,
                  onChanged: (String? value) {
                    setState(() {
                      valorLista = value!;
                    });
                  },
                  items: [
                    for (var i = 1; i < 4; i++)
                      DropdownMenuItem<String>(
                        onTap: () {
                          provider.setSelectedTrimestre(i);
                        },
                        child: Text("${i}"),
                        value: i.toString(),
                      )
                  ],
                );
                return Column(children: [
                  Card(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('trimestre:  '), dropdownButton],
                  )),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: Card(child: barChart(seriesList, orientation))),
                ]);
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
