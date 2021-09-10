abstract class OpState {}

class IdleState extends OpState {}

class TravelState extends OpState {
  final tripData;

  TravelState(this.tripData);
}

class AccidentState extends OpState {}
