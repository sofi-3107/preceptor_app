import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:preceptor_app/custom_widgets/custom_appbar.dart';
import 'package:preceptor_app/custom_widgets/drawer_menu.dart';
import 'package:preceptor_app/models/curso.dart';
import 'package:preceptor_app/services/httpservice.dart';

class Home extends StatelessWidget {
  Home({Key? key, required this.titulo}) : super(key: key);

  final titulo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Preceptor App'),
      drawer: DrawerMenu(),
      body: AnimatedLogo(titulo: titulo),
    );
  }
}

_probarHttp() {}

class AnimatedLogo extends StatelessWidget {
  AnimatedLogo({
    Key? key,
    required this.titulo,
  }) : super(key: key);

  final titulo;

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: BounceInDown(
        duration: Duration(seconds: 2),
        child: Container(
          padding: EdgeInsets.only(left: 100),
          child: Column(
              children: [
                Text(titulo, style: TextStyle(fontSize: 30)),
                SizedBox(height: 30),
                Image.asset('assets/images/eet3107.png', scale: 2)
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center),
        ),
      ),
    );
  }
}
