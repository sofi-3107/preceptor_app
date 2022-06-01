import 'package:flutter/material.dart';
import 'package:preceptor_app/styles/estilos.dart';
import 'package:flutter_sms/flutter_sms.dart';

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
            onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                        'Escriba su numero de celular con formato:+5493876144617'),
                    content: Text(_msgController.text),
                    actions: [
                      Container(
                          padding: EdgeInsets.all(30),
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneController,
                            decoration: InputDecoration(
                                hintText: 'Escriba su número de celular'),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                          _msgController.clear();
                          _phoneController.clear();
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          enviarSMS(
                              _msgController.text, [_phoneController.text]);
                          _msgController.clear();
                          _phoneController.clear();
                          Navigator.pop(context, 'Enviar');
                        },
                        child: const Text('Enviar'),
                      ),
                    ],
                  ),
                ),
            child: Text('Enviar SMS'),
            style: buttonStyle)
      ]),
    );
  }
}
