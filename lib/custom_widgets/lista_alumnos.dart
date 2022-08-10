import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preceptor_app/models/alumno.dart';
import 'package:preceptor_app/providers/preceptor_provider.dart';
import 'package:provider/provider.dart';

class ListaCurso extends StatefulWidget {
  const ListaCurso({Key? key, required this.idCurso}) : super(key: key);
  final int idCurso;
  @override
  _ListaCursoState createState() => _ListaCursoState();
}

class _ListaCursoState extends State<ListaCurso> {
  List<Alumno> alumnos = [];

  @override
  Widget build(BuildContext context) {
    final providerAlumnos = Provider.of<PreceptorProvider>(context);

    return FutureBuilder(
        future: providerAlumnos
            .getAlumnosCursoOfProvider(widget.idCurso)
            .then((value) => alumnos = value),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, i) {
                  print(alumnos[i].asistencias!.isEmpty);
                  return ListTile(
                      title:
                          Text('${alumnos[i].apellido} ${alumnos[i].nombre} '),
                      trailing: DropDownPresente(
                        asistenciaEstado: alumnos[i].asistencias!.isEmpty
                            ? '-'
                            : alumnos[i].asistencias![0].estado!,
                        idAlumno: alumnos[i].id!,
                      ));
                },
                separatorBuilder: (context, i) => Divider(
                      thickness: 2,
                    ),
                itemCount: alumnos.length);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(" Ha ocurrido un error:\n ${snapshot.error}"),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class DropDownPresente extends StatefulWidget {
  DropDownPresente({required this.idAlumno, required this.asistenciaEstado});
  @override
  State<DropDownPresente> createState() => _DropDownPresenteState();
  String asistenciaEstado;
  int idAlumno;
}

class _DropDownPresenteState extends State<DropDownPresente> {
  List estados = ['-', 'ausente', 'presente', 'tarde'];
  late String _listValue;

  @override
  void initState() {
    _listValue = widget.asistenciaEstado;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerAlumnos = Provider.of<PreceptorProvider>(context);

    return DropdownButton(
        value: _listValue,
        onChanged: (String? newVal) => setState(() {
              _listValue = newVal!;
              providerAlumnos.addAsistenciaFromAlumno(
                  _listValue, widget.idAlumno);
            }),
        items: [
          for (String e in estados)
            DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                style: e == 'A'
                    ? TextStyle(color: Colors.red.shade800)
                    : TextStyle(color: Colors.black),
              ),
            )
        ]);
  }
}
