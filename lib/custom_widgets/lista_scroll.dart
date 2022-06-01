import 'package:flutter/material.dart';
import 'package:preceptor_app/custom_widgets/message_box.dart';

class ListScroll extends StatelessWidget {
  const ListScroll({Key? key, required this.alumnos}) : super(key: key);

  final alumnos;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 400),
        child: CustomScrollView(slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            for (var a in alumnos) ListTile(title: Text(a)),
          ]))
        ]));
  }
}
