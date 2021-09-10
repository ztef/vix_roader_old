import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:vix_roader/events/op_events.dart';
import 'package:vix_roader/widgets/form_widgets.dart';

travelDataDialog(context, bloc) {
  final _formKey = GlobalKey<FormBuilderState>();

  final tripController = new TripController(context, bloc);

  final unidades = ['Camion 1', 'Camion 2', 'Vocho', 'Avion', 'Lancha', 'bici'];
  final destinos = [
    'Aguascalientes',
    'Sonora',
    'Nayarit',
  ];
  final clientes = [
    'CEMEX',
    'Soriana',
    'Wallmart',
  ];
  final carga = [
    'Cemento',
    'Varilla',
    'Vacio',
  ];

  return FormBuilder(
      key: _formKey,
      child: SingleChildScrollView(
          child: Column(children: <Widget>[
        formFieldTypeAheadWidget(context, 'unit', 'Unidad', unidades),
        formFieldTypeAheadWidget(context, 'destiny', 'Destino', destinos),
        formFieldTypeAheadWidget(context, 'customer', 'Cliente', clientes),
        formFieldTypeAheadWidget(context, 'load', 'Carga', carga),
        submitButtonWidget('Iniciar Viaje', context, _formKey,
            (data) => tripController.tripReady(data))
      ])));
}

class TripController {
  var data;
  var context;
  var bloc;
  var action;

  TripController(this.context, this.bloc);

  tripReady(data) {
    print('Viaje Listo ');
    this.bloc.add(StartTrip(data));
    Navigator.pop(context);
  }
}

Future modalFullScreen(BuildContext context, bloc) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // Background color
    barrierDismissible: false,
    barrierLabel: 'Dialog',
    transitionDuration: Duration(
        milliseconds:
            400), // How long it takes to popup dialog after button click
    pageBuilder: (BuildContext context, __, ___) {
      // Makes widget fullscreen
      return SizedBox.expand(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('DATOS DEL VIAJE'),
                  ),
                  body: travelDataDialog(context, bloc),
                )),
          ],
        ),
      );
    },
  );
}
