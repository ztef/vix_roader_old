abstract class OpState {}

class LoadingState extends OpState {}

class IdleState extends OpState {}

class TravelState extends OpState {
  final tripStatus;

  TravelState(this.tripStatus);
}

class AccidentState extends OpState {}
