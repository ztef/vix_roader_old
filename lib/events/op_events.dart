abstract class OpEvent {
  const OpEvent();
}

class GotoIdle extends OpEvent {}

class StartingOp extends OpEvent {}

class AttemptToGetStatus extends OpEvent {}

class StartTrip extends OpEvent {
  final tripData;
  const StartTrip(this.tripData) : super();
}

class StopTrip extends OpEvent {}

class AccidentReport extends OpEvent {}

class PauseReport extends OpEvent {}
