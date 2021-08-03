/*this is the state the user is expected to see
class AppState {
  final LocalState currentState;
  const AppState(this.currentState);
}

// helpful navigation pages, you can change
// them to support your pages
enum LocalState {
  state0, // Initial State: Attempt Autoligin
  state1,
  state2,
  notLogged,
  registering,
  logged,
  state5,
}
*/

abstract class AppState {}

class InitialState extends AppState {}

class NotLogged extends AppState {}

class AttemptingToLogin extends AppState {}

class AttemptingToRegister extends AppState {}

class Logged extends AppState {
  final String user;

  Logged({
    this.user = '',
  });

  Logged replaceWith({
    required String user,
  }) {
    return Logged(user: user);
  }
}

class LoginFailed extends AppState {
  final String error;

  LoginFailed(this.error);
}

class Working extends AppState {}
