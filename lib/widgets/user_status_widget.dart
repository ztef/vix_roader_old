import 'package:flutter/material.dart';
import 'package:vix_roader/widgets/box_container_widget.dart';
import 'package:vix_roader/states/op_states.dart';

Widget userStatusWidget({required state}) {
  final text;
  if (state is IdleState) {
    text = 'No Estás de Viaje Aún';
  } else if (state is TravelState) {
    var destino = state.tripStatus.get('tripData')['destiny'];
    text = "Estás de Viaje a $destino";
  } else {
    text = 'Estás de Viaje';
  }

  return Column(
    children: <Widget>[
      boxContainer(Text(text)),
    ],
  );
}
