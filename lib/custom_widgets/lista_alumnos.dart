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
    var cellTextField = DataCell(TextField(
      decoration: InputDecoration(
          labelText: 'minutos', labelStyle: TextStyle(fontSize: 10)),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    ));
    return FutureBuilder(
        future: providerAlumnos
            .getAlumnosCursoOfProvider(widget.idCurso)
            .then((value) => alumnos = value),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DataTable(
              columns: [
                DataColumn(label: Text('Alumno')),
                DataColumn(label: Text('Presente')),
                DataColumn(label: Text('Tardanza'))
              ],
              rows: alumnos
                  .map<DataRow>((a) => DataRow(cells: [
                        DataCell(Text('${a.apellido!}  ${a.nombre!}')),
                        DataCell(CellCheckBox()),
                        cellTextField
                      ]))
                  .toList(),
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

class CellCheckBox extends StatefulWidget {
  @override
  _CellCheckBoxState createState() => _CellCheckBoxState();
}

class _CellCheckBoxState extends State<CellCheckBox> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.purple,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value!;
        });
      },
      value: _isChecked,
    );
  }
}
