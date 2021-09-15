import 'package:flutter/material.dart';
import 'package:vix_roader/domain/end_options.dart';
import 'package:vix_roader/events/op_events.dart';
import 'package:vix_roader/states/op_states.dart';
import 'package:vix_roader/domain/pause_options.dart';

Widget tripStatusWidget({required context, required state, required bloc}) {
  if (state is IdleState) {
    return Container();
  } else if (state is TravelState) {
    var moveStatus = state.tripStatus.get('moveStatus');
    var motivo = PauseOptions.opciones[state.tripStatus.get('pauseReason')];
    var icon = PauseOptions.iconos[state.tripStatus.get('pauseReason')];

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      moveStatus == 'paused' ? Text('Estás en Pausa') : Text('Estás en Ruta'),
      moveStatus == 'paused' ? Text('Motivo : $motivo') : Text(''),
      moveStatus == 'paused' ? Icon(icon) : Text(''),
      _buttons(context, bloc, moveStatus),
    ]);
  } else {
    return Container();
  }
}

Widget _buttons(context, bloc, moveStatus) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
          margin: const EdgeInsets.all(5),
          child: ElevatedButton.icon(
            onPressed: () {
              _pauseDialog(context, bloc);
              //bloc.add(PauseTrip('alimentos'));
            },
            label: Text('PAUSAR'),
            icon: Icon(Icons.pause_circle),
            style: ElevatedButton.styleFrom(
              primary: Colors.purple,
            ),
          )),
      moveStatus == 'paused'
          ? Container(
              margin: const EdgeInsets.all(5),
              child: ElevatedButton.icon(
                onPressed: () {
                  bloc.add(UnPauseTrip());
                },
                label: Text('PONER EN RUTA'),
                icon: Icon(Icons.play_circle),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                ),
              ))
          : Container(),
    ],
  );
}

Future<void> _pauseDialog(context, bloc) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Modal, debe presionar algo
    builder: (BuildContext context) {
      var selectedPauseOption = '';

      return AlertDialog(
          title: const Text('Motivo de Pausa'),
          content: StatefulBuilder(
            builder: (BuildContext _context, StateSetter setState) {
              return Container(
                  height: 600.0,
                  width: 300.0,
                  child: Column(
                    children: <Widget>[
                      //Text(PauseOptions.opciones[selectedPauseOption]),
                      //Expanded(
                      //    child:
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: PauseOptions.opciones.length,
                        itemBuilder: (BuildContext context, int index) {
                          String key =
                              PauseOptions.opciones.keys.elementAt(index);
                          return new Row(
                            children: <Widget>[
                              PauseOption(
                                  text: PauseOptions.opciones[key],
                                  icon: PauseOptions.iconos[key],
                                  onClicked: () => {
                                        setState(
                                            () => {selectedPauseOption = key}),
                                        bloc.add(
                                            PauseTrip(selectedPauseOption)),
                                        Navigator.of(_context).pop()
                                      }),
                            ],
                          );
                        },
                      ),
                      //),
                      TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            //bloc.add(PauseTrip(selectedPauseOption));
                            Navigator.of(_context).pop();
                          }),
                    ],
                  ));
            },
          ));
    },
  );
}

class PauseOption extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final icon;

  PauseOption({
    Key? key,
    required this.text,
    required this.icon,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          //shape: StadiumBorder(),
          primary: Colors.purple,
          //padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        label: Text(text),
        icon: Icon(icon),
        onPressed: onClicked,
      );
}

Future<void> stopTripDialog(context, bloc) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Modal, debe presionar algo
    builder: (BuildContext context) {
      var selectedEndOption = '';

      return AlertDialog(
          title: const Text('Terminación de Viaje'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: 400.0,
                  width: 300.0,
                  child: Column(
                    children: <Widget>[
                      Text(EndOptions.opciones[selectedEndOption]),
                      Expanded(
                          child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: EndOptions.opciones.length,
                        itemBuilder: (BuildContext context, int index) {
                          String key =
                              EndOptions.opciones.keys.elementAt(index);
                          return new Row(
                            children: <Widget>[
                              PauseOption(
                                  text: EndOptions.opciones[key],
                                  icon: EndOptions.iconos[key],
                                  onClicked: () => {
                                        setState(
                                            () => {selectedEndOption = key})
                                      }),
                            ],
                          );
                        },
                      )),
                      Row(
                        children: [
                          TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          TextButton(
                              child: const Text('Terminar'),
                              onPressed: () {
                                bloc.add(StopTrip(selectedEndOption));
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    ],
                  ));
            },
          ));
    },
  );
}
