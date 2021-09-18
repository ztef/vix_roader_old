// Calcula el Tiempo de Conduccion Acumulado :
getAcumulatedDriveTime(List tripLog) {
  int i = 0;

  DateTime _topTime = DateTime.now();
  DateTime _baseTime = DateTime.now();

  Duration elapsedTime = Duration(seconds: 0);

  Duration driveTime = Duration(seconds: 0);
  Duration pauseTime = Duration(seconds: 0);

  String baseAction = '';

  bool firstRecord = true;

  // Recorre eventos del Viaje en orden de Tiempo ;
  while ((i < tripLog.length)) {
    var item = tripLog.elementAt(i);

    // Excepto el Primer Registro :
    if (firstRecord) {
      _baseTime = item['timeStamp'];
      firstRecord = false;
    } else {
      _topTime = item['timeStamp'];
      elapsedTime = _topTime.difference(_baseTime);
      if (baseAction == 'P') {
        // Acumula como Pausa
        pauseTime =
            Duration(seconds: pauseTime.inSeconds + elapsedTime.inSeconds);
      }
      if (baseAction == 'D') {
        // Acumula como Drive
        driveTime =
            Duration(seconds: driveTime.inSeconds + elapsedTime.inSeconds);
      }
      _baseTime = _topTime; // Ahora el Top es la base
    }

    if (item['data']['action'] == 'StartTrip') {
      baseAction = 'P';
    }
    if (item['data']['action'] == 'PauseTrip') {
      baseAction = 'P';
    }
    if (item['data']['action'] == 'UnPauseTrip') {
      baseAction = 'D';
    }

    i++;
  }
  // Si la ultima accion es D, acumula driveTime hasta Now()
  if (baseAction == 'D') {
    elapsedTime = DateTime.now().difference(_baseTime);
    driveTime = Duration(seconds: driveTime.inSeconds + elapsedTime.inSeconds);
  }
  // Si la ultima accion es P, acumula pauseTime hasta Now()
  if (baseAction == 'P') {
    elapsedTime = DateTime.now().difference(_baseTime);
    pauseTime = Duration(seconds: pauseTime.inSeconds + elapsedTime.inSeconds);
  }

  return {'driveTime': driveTime, 'pauseTime': pauseTime};
}

tripStatsCalc(tripHistory) {
  int i = 0;
  Duration _tripTime = Duration(seconds: 0);
  Duration _driveTime = Duration(seconds: 0);
  Duration _pauseTime = Duration(seconds: 0);

  Duration tripTime = Duration(seconds: 0);
  Duration driveTime = Duration(seconds: 0);
  Duration pauseTime = Duration(seconds: 0);

  while (i < tripHistory.length) {
    var item = tripHistory.elementAt(i);
    if (item['tripTimes'] != null) {
      _driveTime = item['tripTimes']['driveTime'];
      _pauseTime = item['tripTimes']['pauseTime'];

      driveTime = Duration(seconds: driveTime.inSeconds + _driveTime.inSeconds);
      pauseTime = Duration(seconds: pauseTime.inSeconds + _pauseTime.inSeconds);
    }
    if (item['tripDates'] != null) {
      _tripTime =
          item['tripDates']['stop'].difference(item['tripDates']['stop']);
      tripTime = Duration(seconds: tripTime.inSeconds + _tripTime.inSeconds);
    }

    i++;
  }
  return {
    'trips': i,
    'tripTime': tripTime,
    'driveTime': driveTime,
    'pauseTime': pauseTime
  };
}

getTripDates(tripStatus) {
  return ({'start': tripStatus.timestamp, 'stop': DateTime.now()});
}

// Formatea Duration como hh:mm:ss
timeFormat(Duration d) => d.toString().split('.').first.padLeft(8, "0");
