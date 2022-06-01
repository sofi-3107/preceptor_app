import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class GraficoPie extends StatelessWidget {
  const GraficoPie(
      {Key? key,
      required this.datos,
      required this.tituloGrafico,
      required this.colorList})
      : super(key: key);
  final Map<String, double> datos;
  final tituloGrafico;
  final colorList;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(children: [
      SizedBox(height: 20),
      Text(tituloGrafico, style: TextStyle(fontSize: 20)),
      SizedBox(height: 20),
      PieChart(
        dataMap: datos,
        chartRadius: MediaQuery.of(context).size.width / 1.7,
        legendOptions: LegendOptions(
            legendPosition: LegendPosition.bottom,
            legendTextStyle: TextStyle(fontSize: 18)),
        chartValuesOptions:
            ChartValuesOptions(showChartValuesInPercentage: true),
        colorList: colorList,
      ),
    ])));
  }
}
