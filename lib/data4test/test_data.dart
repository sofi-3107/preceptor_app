import 'dart:math';

import 'package:preceptor_app/example_data/alumno.dart';
import 'package:preceptor_app/example_data/materia.dart';

List<String> apellidos = ['Juarez', 'Lopez', 'Ibañez', 'Herrera', 'Singh'];
List<String> nombres = ['Juan', 'Paola', 'Pedro', 'Ivana', 'Mariano'];
List<String> dni = ['12369856', '14785963', '13698745', '32587412', '47896312'];
List<String> nombresMaterias = [
  'Matematica',
  'Ingles',
  'Economia',
  'Historia',
  'Geografia'
];

var random = Random();

listaAlumnos() {
  List<Alumno> alumnos = [];
  for (var i = 0; i <= 5; i++) {
    var randomNumber = random.nextInt(4);
    alumnos.add(Alumno(
        nombres[randomNumber], apellidos[randomNumber], dni[randomNumber]));
    return alumnos;
  }
}

listaMaterias() {
  List<Materia> materias = [];
  for (var i = 0; i <= 5; i++) {
    var randomNumber = random.nextInt(4);
    materias.add(Materia(nombresMaterias[randomNumber]));
    return materias;
  }
}

List<Alumno> listaAlumnosConMaterias() {
  return listaAlumnos().forEach((al) => al.addMaterias(listaMaterias()));
}
