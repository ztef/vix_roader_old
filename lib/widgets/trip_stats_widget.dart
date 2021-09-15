import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:vix_roader/repositories/app_repository.dart';

import 'package:vix_roader/states/op_states.dart';

Widget currentTripStatsWidget({required state, required context}) {
  var tripNumber = 0;

  List tripLog = RepositoryProvider.of<AppRepository>(context).getTripLog();

  var startedAt = getStartTravelTime(tripLog);
  var driveTime = getDriveTime(tripLog);
  var timeStamp = DateTime.now();

  tripNumber = state.tripStatus.get('tripCounter');

  return Container(
      decoration: BoxDecoration(
        //color: const Color(0xff7c94b6),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        children: <Widget>[
          Text('Número de Viaje : $tripNumber'),
          Text(
              'Hora de Inicio : ${DateFormat('yyyy-MM-dd – kk:mm').format(startedAt)}'),
          Text('Tiempo de Viaje :'),
          TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
            return Text("${timeFormat(DateTime.now().difference(startedAt))}");
          }),
          Text('Tiempo de Conducción :'),
          state.tripStatus.get('moveStatus') == 'route'
              ? TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
                  return Text(
                      "${timeFormat(Duration(seconds: driveTime.inSeconds + DateTime.now().difference(timeStamp).inSeconds))}");
                })
              : Text(timeFormat(driveTime)),
        ],
      ));
}

// Formatea Duration como hh:mm:ss
timeFormat(Duration d) => d.toString().split('.').first.padLeft(8, "0");

// Regresa el timeStamp del ultimo StartTrip
DateTime getStartTravelTime(List tripLog) {
  int i = 0;
  DateTime _startTime = DateTime.now();

  bool found = false;

  while ((i < tripLog.length) && !found) {
    var item = tripLog.elementAt(tripLog.length - 1 - i);
    // Encuentra el ultimo inicio de viaje
    if (item['data']['action'] == 'StartTrip') {
      _startTime = item['timeStamp'];
      found = true;
    }
    i++;
  }

  return _startTime;
}

// Calcula el Tiempo de Conduccion Acumulado :
Duration getDriveTime(List tripLog) {
  int i = 0;
  DateTime _baseTime = DateTime.now();
  DateTime _topTime = DateTime.now();
  Duration elapsedTime = Duration(seconds: 0);
  Duration totalTime = Duration(seconds: 0);

  bool foundBase = false;
  bool foundTop = false;

  // Busca el primer UnPause ;
  while ((i < tripLog.length)) {
    var item = tripLog.elementAt(tripLog.length - 1 - i);
    // Encuentra un UnPauseTrip (acumula)
    if (item['data']['action'] == 'UnPauseTrip') {
      _baseTime = item['timeStamp'];
      foundBase = true;
      foundTop = false;
    }
    // Encuentra una pausa
    if (item['data']['action'] == 'PauseTrip') {
      _topTime = item['timeStamp'];
      if (foundBase) {
        // calcula en elapsedTime el tiempo de intervalo.
        elapsedTime = _topTime.difference(_baseTime);
        totalTime =
            Duration(seconds: totalTime.inSeconds + elapsedTime.inSeconds);
        foundTop = true;
        foundBase = false;
      }
    }
    i++;
  }
  // Si no encuentra Pausa al final usa como top el Now()
  if (!foundTop) {
    elapsedTime = DateTime.now().difference(_baseTime);
    totalTime = Duration(seconds: totalTime.inSeconds + elapsedTime.inSeconds);
  }

  return totalTime;
}











/*getTotalTravelTime(List tripLog) {
  var t = 0;
  int i = 0;
  DateTime _startTime = DateTime.now();
  Duration timeLapse;

  bool found = false;

  while ((i < tripLog.length) && !found) {
    var item = tripLog.elementAt(tripLog.length - 1 - i);
    // Encuentra el ultimo inicio de viaje
    if (item['data']['action'] == 'StartTrip') {
      _startTime = item['timeStamp'];
      found = true;
    }
    i++;
  }
  if (found) {
    timeLapse = DateTime.now().difference(_startTime);
    t = timeLapse.inSeconds;
  }

  return t;
} */
