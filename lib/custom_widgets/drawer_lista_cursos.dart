import 'package:flutter/material.dart';
import 'package:preceptor_app/models/curso.dart';
import 'package:preceptor_app/pantallas/asistencia.dart';
import 'package:preceptor_app/providers/preceptor_provider.dart';
import 'package:provider/provider.dart';

class DrawerListaCursos extends StatelessWidget {
  DrawerListaCursos({
    Key? key,
  }) : super(key: key);

  List<Curso> cursos = [];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreceptorProvider>(context);

    return FutureBuilder(
        future: provider
            .getCursosPreceptorOfProvider(1)
            .then((value) => cursos = value),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            return ListView.separated(
                separatorBuilder: (BuildContext context, int i) {
                  return Divider(
                    thickness: 2,
                  );
                },
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: cursos.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    title: Text(
                        '${cursos[i].nivel!.nivel}º ${cursos[i].division}º C${cursos[i].nivel!.ciclo![0]} T${cursos[i].turno![0]}'),
                    contentPadding: const EdgeInsets.only(left: 20.0),
                    onTap: () {
                      provider.setSelectedCurso(cursos[i]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Asistencia()));
                    },
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
