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
    return ListaAlumnos();
  }
}

class ListaAlumnos extends StatelessWidget {
  ListaAlumnos({
    Key? key,
  }) : super(key: key);

  List<Curso> cursos = [];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreceptorProvider>(context);
    print(
        'filtro_lista idcurso desde el map : ${provider.idCursos[provider.selectedCursoFilter]}');
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
          isListaCurso: false, textlegend: 'Filtrar por Cantidad de Faltas'),
      ListScroll(idCurso: provider.idCursos[provider.selectedCursoFilter]!),
    ]);
  }
}

class FilterContainer extends StatefulWidget {
  FilterContainer(
      {Key? key,
      this.lista,
      required this.textlegend,
      required this.isListaCurso})
      : super(key: key);
  final bool isListaCurso;
  final List<Curso>? lista;
  final String? textlegend;

  @override
  State<FilterContainer> createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer> {
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
  late String _currentValue = cantidadFaltas[0];

  @override
  void initState() {
    super.initState();
    _setInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreceptorProvider>(context);

    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.green, Colors.black87]),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
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
                      widget.isListaCurso
                          ? provider.setFilterCurso(_currentValue)
                          : provider.setFilterCantidadFaltas(_currentValue);
                    });
                  },
                  items: widget.isListaCurso
                      ? widget.lista!
                          .map<
                              DropdownMenuItem<
                                  String>>((Curso m) => DropdownMenuItem(
                              value:
                                  '${m.nivel!.nivel}º ${m.division}º C${m.nivel!.ciclo![0]} T${m.turno![0]}',
                              child: Text(
                                  '${m.nivel!.nivel}º ${m.division}º C${m.nivel!.ciclo![0]} T${m.turno![0]}')))
                          .toList()
                      : cantidadFaltas
                          .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList())
            ],
          ),
        ));
  }

  _setInitialValue() {
    if (widget.isListaCurso) {
      _currentValue = widget.lista!
          .map((m) =>
              '${m.nivel!.nivel}º ${m.division}º C${m.nivel!.ciclo![0]} T${m.turno![0]}')
          .toList()[0];
    } else {
      _currentValue = cantidadFaltas[0];
    }
  }
}
