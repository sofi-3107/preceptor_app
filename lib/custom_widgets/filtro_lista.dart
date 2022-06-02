import 'dart:io';

import 'package:flutter/material.dart';
import 'package:preceptor_app/data4test/test_data.dart';
import 'package:preceptor_app/models/curso.dart';
import 'package:preceptor_app/providers/preceptor_provider.dart';
import 'package:provider/provider.dart';

import 'lista_scroll.dart';

class FIltroLista extends StatelessWidget {
  const FIltroLista({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var column = Column(
      children: [Text('data'), Text('data'), Text('data')],
    );
    return ListaAlumnos();
  }
}

class ListaAlumnos extends StatelessWidget {
  ListaAlumnos({
    Key? key,
  }) : super(key: key);

  List students = [
    'Juan Araujo',
    'Eduardo Aramayo',
    'Pablo Pelaya',
    'Joaquin Estebanez',
    'Juan Araujo',
    'Eduardo Aramayo',
    'Pablo Pelaya',
    'Joaquin Estebanez'
  ];
  List<Curso> cursos = [];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreceptorProvider>(context);
    List<String> cursosNombres = provider.cursosPreceptor
        .map<String>((Curso m) =>
            '${m.nivel!.nivel}º ${m.division}º C${m.nivel!.ciclo![0]} T${m.turno![0]}')
        .toList();
    List<String> cantidadFaltas = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15'
    ];
    return Column(children: [
      FilterContainer(
          isListaCurso: true,
          lista: provider.cursosPreceptor,
          textlegend: 'Filtrar por Curso'),
      Divider(
        height: 1,
        thickness: 0.5,
      ),
      FilterContainer(
          isListaCurso: false,
          lista: cantidadFaltas,
          textlegend: 'Filtrar por Cantidad de Faltas'),
      ListScroll(alumnos: students),
    ]);
  }
}

class FilterContainer extends StatefulWidget {
  FilterContainer(
      {Key? key,
      required this.lista,
      required this.textlegend,
      required this.isListaCurso})
      : super(key: key);
  final bool isListaCurso;
  final List lista;
  final String? textlegend;

  @override
  State<FilterContainer> createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer> {
  late String _currentValue;
  late List<String> itemsList;
  @override
  void initState() {
    super.initState();
    _buildMenuItemsTexts();
  }

  @override
  Widget build(BuildContext context) {
    itemsList.forEach((i) => print(i));
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.green, Colors.black87]),
      ),
      //color: Colors.green[100],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(children: [
          Expanded(
              child: Text(widget.textlegend.toString(),
                  style: TextStyle(color: Colors.white))),
          DropdownButton(
              dropdownColor: Colors.green,
              style: const TextStyle(color: Colors.white),
              value: _currentValue,
              onChanged: (String? value) {
                setState(() {
                  _currentValue = value!;
                });
              },
              items: itemsList
                  .map<DropdownMenuItem<String>>(
                      (m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList()),
        ]),
      ),
    );
  }

  _buildMenuItemsTexts() {
    widget.isListaCurso
        ? itemsList = widget.lista
            .map<String>((m) =>
                '${m.nivel!.nivel}º ${m.division}º C${m.nivel!.ciclo![0]} T${m.turno![0]}-id:${m.id}')
            .toList()
        : itemsList = widget.lista as List<String>;
    _currentValue = widget.lista[0];
  }
}
