import 'package:flutter/material.dart';
import 'package:preceptor_app/pantallas/grafico_materias.dart';
import 'package:preceptor_app/pantallas/home.dart';
import 'package:preceptor_app/pantallas/sms.dart';
import 'package:preceptor_app/providers/preceptor_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => PreceptorProvider(),
    child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(
                titulo: 'Preceptor App',
              ),
          '/sms': (context) => const SmsNotifier(),
          '/materias': (context) => const GraficoMaterias(),
        },
        debugShowCheckedModeBanner: false),
  ));
}
