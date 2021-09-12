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

class PauseTrip extends OpEvent {
  final pauseReason;
  const PauseTrip(this.pauseReason) : super();
}

class UnPauseTrip extends OpEvent {}

class StopTrip extends OpEvent {
  final stopStatus;
  const StopTrip(this.stopStatus) : super();
}

class AccidentReport extends OpEvent {}

class PauseReport extends OpEvent {}
