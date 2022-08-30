import 'package:flutter/material.dart';
import 'package:preceptor_app/example_data/alumno.dart';
import 'package:preceptor_app/providers/preceptor_provider.dart';
import 'package:preceptor_app/services/httpservice.dart';
import 'package:preceptor_app/styles/estilos.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({Key? key, @required this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreceptorProvider>(context);
    String nombre = '';
    return AppBar(
      title: FutureBuilder(
        future:
            provider.obtenerNombrePreceptor(1).then((value) => nombre = value),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(children: [
              Text(title!, style: TextStyle(fontSize: 15)),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Preceptor/a: $nombre',
                style: TextStyle(fontSize: 15),
              )
            ]);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Ha ocurrido un error'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: const [Colors.cyan, Colors.black26])),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100.0);
}
