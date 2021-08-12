import 'package:vix_roader/states/auth_states.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class NavigateTo extends AuthEvent {
  final AuthState destinationState;
  const NavigateTo(this.destinationState);
}

class AuthStart extends AuthEvent {}

class AttemptToLogin extends AuthEvent {
  final userCredentials;
  const AttemptToLogin(this.userCredentials) : super();
}

class GoToRegister extends AuthEvent {}

class GoToLogin extends AuthEvent {}

class AttemptToRegister extends AuthEvent {
  final userCredentials;
  const AttemptToRegister(this.userCredentials) : super();
}

class AttemptToLogOut extends AuthEvent {}
