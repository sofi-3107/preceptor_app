import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preceptor_app/models/alumno.dart';
import 'package:preceptor_app/providers/preceptor_provider.dart';
import 'package:preceptor_app/styles/estilos.dart';
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
    // print('id del curso en lista alumnos: ${widget.idCurso}');
    final providerAlumnos = Provider.of<PreceptorProvider>(context);

    return FutureBuilder(
        future: providerAlumnos
            .getAlumnosCursoOfProvider(widget.idCurso)
            .then((value) => alumnos = value),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, i) {
                    return ListTile(
                        title:
                            Text('${alumnos[i].apellido} ${alumnos[i].nombre}'),
                        trailing: DropDownPresente());
                  },
                  separatorBuilder: (context, i) => Divider(
                        thickness: 2,
                      ),
                  itemCount: alumnos.length),
            );
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
  @override
  State<DropDownPresente> createState() => _DropDownPresenteState();
}

class _DropDownPresenteState extends State<DropDownPresente> {
  List estados = ['A', 'P', 'T'];
  String _listValue = 'A';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: _listValue,
        onChanged: (String? newVal) => setState(() {
              _listValue = newVal!;
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
                ))
        ]);
  }
}
