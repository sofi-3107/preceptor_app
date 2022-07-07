import 'package:flutter/material.dart';
import 'package:preceptor_app/providers/preceptor_provider.dart';
import 'package:preceptor_app/styles/estilos.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../sharing.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  late TextEditingController _phoneController;
  late TextEditingController _msgController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _msgController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _msgController.dispose();
    super.dispose();
  }

  var msg;
  var phone;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreceptorProvider>(context);
    return Container(
      decoration: greenGradientBox,
      padding: EdgeInsets.symmetric(horizontal: 20),
      //color: Color(0XFCE4CA),
      child: Column(children: [
        Text(
          'Mensaje para los tutores',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(height: 15),
        TextField(
            onChanged: provider.setMessageSMS(_msgController.text),
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 3,
            maxLength: 100,
            controller: _msgController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.amber),
                labelText: 'Escriba un mensaje corto')),
        ElevatedButton(
            child: Icon(Icons.message_outlined, color: Colors.white),
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(
                    side: BorderSide(width: 1, color: Colors.white)),
                padding: EdgeInsets.all(10),
                primary: Colors.green.shade700),
            onPressed: () {
              enviarSMS(_msgController.text, provider.getTelefonosTutores());
              provider.getTelefonosTutores().forEach(print);
              _msgController.clear();
              _phoneController.clear();
              Navigator.pop(context, 'Enviar');
            }),
      ]),
    );
  }
}
