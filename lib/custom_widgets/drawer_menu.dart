import 'package:flutter/material.dart';
import 'package:preceptor_app/styles/estilos.dart';

import 'drawer_lista_cursos.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Image.asset('assets/images/eet3107.png', scale: 5),
          decoration: boxGradientDecoration,
        ),
        ListTile(
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            title: Text('Home',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        Divider(
          thickness: 3,
        ),
        ListTile(
            leading: Icon(Icons.people),
            title: Text('Cursos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        Divider(
          thickness: 3,
        ),
        Container(
          child: DrawerListaCursos(),
        ),
        Divider(thickness: 3),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('Comunicados por SMS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          onTap: () {
            Navigator.pushNamed(context, '/sms');
          },
        ),
        Divider(
          thickness: 3,
        ),
      ],
    ));
  }
}
