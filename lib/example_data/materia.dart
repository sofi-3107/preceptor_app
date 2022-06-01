import 'dart:math';

class Materia {
  String nombre = '';
  int trimestre = 1;
  double nota = 0;

  final ran = Random();

  Materia(this.nombre) {
    nota = ran.nextDouble();
  }
}
