import 'package:flutter/material.dart';

import 'package:preceptor_app/custom_widgets/custom_appbar.dart';

import 'package:preceptor_app/custom_widgets/drawer_menu.dart';

class Preceptor extends StatelessWidget {
  const Preceptor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Juan'),
      drawer: DrawerMenu(),
    );
  }
}
