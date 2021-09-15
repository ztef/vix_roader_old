import 'package:flutter/material.dart';

class TripState {
  static Map texto = {
    'StartTrip': 'Viaje Iniciado',
    'PauseTrip': 'Parada',
    'StopTrip': 'Viaje Terminado',
    'UnPauseTrip': 'En Ruta',
  };

  static Map icono = {
    'StartTrip': Icons.add_road,
    'PauseTrip': Icons.pause_circle,
    'StopTrip': Icons.stop_circle,
    'UnPauseTrip': Icons.play_circle,
  };
}
