import 'materia.dart';

class Alumno {
  String nombre = "";
  String apellido = "";
  String dni = "";

  List<Materia> _materias = [];

  String cursor = "";

  Alumno(this.nombre, this.apellido, this.dni);

  List<Materia> getMaterias() => _materias;

  void addMateria(Materia materia) => _materias.add(materia);

  void addMaterias(List<Materia> materiasAdd) => _materias.addAll(materiasAdd);
}
