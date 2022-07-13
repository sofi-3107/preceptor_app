class CalculosAuxiliares {
  static int getCurrentTrimestre() {
    var hoy = DateTime.now();
    var currentYear = DateTime.now().year;
    var inicioPrimerTrimestre = DateTime(currentYear, 3, 4);
    var finPrimerTrimestre = DateTime(currentYear, 7, 9);
    var inicioSegundoTrimestre = DateTime(currentYear, 6, 10);
    var finSegundoTrimestre = DateTime(currentYear, 9, 10);
    var inicioTercerTrimestre = DateTime(currentYear, 9, 11);
    var finTercerTrimestre = DateTime(currentYear, 12, 21);

//Se califica hasta el ultimo dia del trimestre pero no el primero
    if ((hoy.compareTo(inicioPrimerTrimestre) == 1 &&
            hoy.compareTo(finPrimerTrimestre) == -1) ||
        (hoy.compareTo(finPrimerTrimestre) == 0)) {
      return 1;
    } else if ((hoy.compareTo(inicioSegundoTrimestre) == 1 &&
            hoy.compareTo(finSegundoTrimestre) == -1) ||
        (hoy.compareTo(finSegundoTrimestre) == 0)) {
      return 2;
    } else if ((hoy.compareTo(inicioTercerTrimestre) == 1 &&
            hoy.compareTo(finTercerTrimestre) == -1) ||
        (hoy.compareTo(finTercerTrimestre) == 0)) {
      return 3;
    }

    return 0;
  }
}
