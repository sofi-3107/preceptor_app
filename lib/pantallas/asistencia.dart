import 'package:flutter/material.dart';
import 'package:preceptor_app/custom_widgets/custom_appbar.dart';
import 'package:preceptor_app/custom_widgets/drawer_menu.dart';
import 'package:preceptor_app/custom_widgets/lista_alumnos.dart';
import 'package:preceptor_app/models/curso.dart';
import 'package:preceptor_app/providers/preceptor_provider.dart';
import 'package:preceptor_app/services/httpservice.dart';
import 'package:preceptor_app/styles/estilos.dart';
import 'package:provider/provider.dart';

class Asistencia extends StatelessWidget {
  HttpService ss = HttpService();

  @override
  Widget build(BuildContext context) {
    const snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Asistencia guardada correctamente',
          style: TextStyle(color: Colors.white),
        ));
    final provider = Provider.of<PreceptorProvider>(context);
    Curso curso = provider.getSelectedCurso();
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: CustomAppbar(
          title:
              '${curso.nivel!.nivel}º ${curso.division}º C${curso.nivel!.ciclo![0]} T${curso.turno![0]} \n ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
      drawer: DrawerMenu(),
      body: Column(children: [
        SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 450),
                child: ListaCurso(idCurso: curso.id!))),
        SizedBox(height: 20),
        ElevatedButton(
          style: buttonStyle,
          child: Text('Ver Gráfico Materias'),
          onPressed: () {
            Navigator.pushNamed(context, '/materias');
          },
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: buttonStyle,
                  child: Text('Modificar')),
              Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: () {
                  print('Asistencias lista: ${provider.asistencias}');
                  provider.guardarAsistencias();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text('Guardar'),
                style: buttonStyle,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
