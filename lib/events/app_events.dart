import 'package:vix_m/states/app_states.dart';

abstract class AppEvent {
  const AppEvent();
}

class NavigateTo extends AppEvent {
  final AppState destinationState;
  const NavigateTo(this.destinationState);
}

class AppStarted extends AppEvent {}

class AttemptToLogin extends AppEvent {
  final userCredentials;
  const AttemptToLogin(this.userCredentials) : super();
}

class AttemptToRegister extends AppEvent {}

class AttemptToLogOut extends AppEvent {}
