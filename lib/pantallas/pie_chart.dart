import 'dart:math';

import 'package:flutter/material.dart';

import 'package:preceptor_app/custom_widgets/custom_appbar.dart';
import 'package:preceptor_app/custom_widgets/drawer_menu.dart';
import 'package:preceptor_app/custom_widgets/pie_chart.dart';
import 'package:preceptor_app/styles/estilos.dart';

class PieChartGraphic extends StatelessWidget {
  const PieChartGraphic({Key? key}) : super(key: key);

  _getData() {
    Map<String, double> alumnos = {};
    var rand = Random();
    alumnos['Desaprobados'] = rand.nextDouble() * 10;
    alumnos['Aprobados'] = 30 - alumnos['Desaprobados']!;
    return alumnos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: 'Pie'),
        drawer: DrawerMenu(),
        body: SingleChildScrollView(
          child: GraficoPie(
            datos: _getData(),
            tituloGrafico: 'Aprobados y Desaprobados',
            colorList: [Colors.cyan, Colors.amber],
          ),
        ));
  }
}
