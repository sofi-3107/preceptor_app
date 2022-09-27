import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preceptor_app/custom_widgets/message_box.dart';
import 'package:preceptor_app/models/alumno.dart';
import 'package:preceptor_app/providers/preceptor_provider.dart';
import 'package:preceptor_app/sharing.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ListScroll extends StatelessWidget {
  ListScroll(/*this.idCurso,*/ {Key? key, this.cantidadFaltas})
      : super(key: key);
  /*final int? idCurso;*/
  final int? cantidadFaltas;
  List<Alumno> alumnos = [];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreceptorProvider>(context);
    return FutureBuilder(
      future: provider
          .getAlumnosCursoOfProvider(provider.getIdCurso()!)
          .then((value) => alumnos = value),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(' SNAPSHOT ERROR: ${snapshot.error}');
          return const Center(child: Text('Ha ocurrido un error: '));
        } else if (snapshot.hasData) {
          return ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 400,
              ),
              child: CustomScrollView(slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  for (var a in alumnos)
                    if (a.asistencias!
                            .where((a) => a.estado == 'ausente')
                            .length >=
                        provider.getCantidadFaltas())
                      ListTile(
                        leading: FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.green.shade700,
                        ),
                        onTap: () => enviarWhatsap(
                            provider.getMessageSMS(), [a.tutor!.telefono!]),
                        title: Text(
                            '${a.apellido!} ${a.nombre!}   Faltas: ${a.asistencias!.where((a) => a.estado == 'ausente').length}   Tutor: ${a.tutor!.telefono}'),
                        trailing: IconButton(
                            onPressed: () async =>
                                await launch('tel:${a.tutor!.telefono!}'),
                            icon: Icon(Icons.phone,
                                color: Colors.green.shade800)),
                      ),
                ]))
              ]));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
