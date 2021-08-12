abstract class AuthState {}

class InitialState extends AuthState {}

class NotLogged extends AuthState {}

class AttemptingToLogin extends AuthState {}

class NotRegistered extends AuthState {}

class AttemptingToRegister extends AuthState {}

class Logged extends AuthState {
  final String? user;

  Logged({
    this.user = '',
  });

  Logged replaceWith({
    required String user,
  }) {
    return Logged(user: user);
  }
}

class LoginFailed extends AuthState {
  final String error;

  LoginFailed(this.error);
}

class RegisterFailed extends AuthState {
  final String error;

  RegisterFailed(this.error);
}

class Working extends AuthState {}
