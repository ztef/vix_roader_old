import 'package:flutter/material.dart';

class PauseOptions {
  static Map opciones = {
    '': 'Iniciando',
    'fuel': 'Cargando Combustible',
    'waitingLoad': 'Esperando Carga',
    'loading': 'Cargando',
    'downloading': 'Descargando',
    'rest': 'Descanso',
    'food': 'Alimentos',
    'repair': 'Reparando Avería',
    'ret': 'Retén',
    'police': 'Policía',
  };

  static Map iconos = {
    '': Icons.circle,
    'fuel': Icons.ev_station,
    'waitingLoad': Icons.access_time,
    'loading': Icons.arrow_circle_up,
    'downloading': Icons.arrow_circle_down,
    'rest': Icons.hotel,
    'food': Icons.restaurant,
    'repair': Icons.error,
    'ret': Icons.dangerous,
    'police': Icons.local_police,
  };
}
