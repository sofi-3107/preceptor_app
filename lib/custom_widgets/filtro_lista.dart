import 'dart:io';

import 'package:flutter/material.dart';
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
    return Column(children: [
      FilterContainer(
          isListaCurso: true,
          lista: provider.cursosPreceptor,
          textlegend: 'Filtrar por Curso'),
      Divider(
        height: 1,
        thickness: 0.1,
      ),
      FilterContainer(
          isListaCurso: false, textlegend: 'Filtrar por Cantidad de Faltas'),
      ListScroll(), // el provider.id Curso queda null
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
                    });
                  },
                  items: widget.isListaCurso
                      ? widget.lista!
                          .map<
                              DropdownMenuItem<
                                  String>>((Curso m) => DropdownMenuItem(
                              onTap: () {
                                provider.setIdCurso(m.id!);
                              },
                              alignment: AlignmentDirectional.center,
                              value:
                                  '${m.nivel!.nivel}º ${m.division}º C${m.nivel!.ciclo![0]} T${m.turno![0]}',
                              child: Text(
                                  '${m.nivel!.nivel}º ${m.division}º C${m.nivel!.ciclo![0]} T${m.turno![0]}')))
                          .toList()
                      : cantidadFaltas
                          .map<DropdownMenuItem<String>>((e) =>
                              DropdownMenuItem(
                                  onTap: () =>
                                      provider.setCantidadFaltas(int.parse(e)),
                                  alignment: AlignmentDirectional.center,
                                  value: e,
                                  child: Text(e)))
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
