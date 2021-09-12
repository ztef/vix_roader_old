import 'package:flutter/material.dart';

class EndOptions {
  static Map opciones = {
    '': 'Sin Motivo',
    'normal': 'Terminación Normal',
    'illness': 'Cancelación por Enfermedad',
    'accident': 'Cancelación por Accidente',
    'broken': 'Cancelación por Descompostura',
    'law': 'Problema Legal',
    'assault': 'Robo / Asalto',
  };

  static Map iconos = {
    '': Icons.circle,
    'normal': Icons.stop,
    'illness': Icons.local_hospital,
    'accident': Icons.access_alarm,
    'broken': Icons.auto_fix_high,
    'law': Icons.local_police,
    'assault': Icons.safety_divider,
  };
}
