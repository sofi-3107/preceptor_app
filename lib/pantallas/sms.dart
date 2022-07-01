import 'package:flutter/material.dart';
import 'package:preceptor_app/custom_widgets/custom_appbar.dart';
import 'package:preceptor_app/custom_widgets/drawer_menu.dart';
import 'package:preceptor_app/custom_widgets/filtro_lista.dart,bkp';
import 'package:preceptor_app/custom_widgets/message_box.dart';

class SmsNotifier extends StatelessWidget {
  const SmsNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Comunicados a Tutores',
        ),
        drawer: DrawerMenu(),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              //padding: EdgeInsets.symmetric(horizontal: 5),
              child: FIltroLista()),
          MessageBox()
        ])),
      ),
    );
  }
}
