import 'package:bloc/bloc.dart';
import 'package:vix_roader/events/auth_events.dart';
import 'package:vix_roader/states/auth_states.dart';
import 'package:vix_roader/repositories/auth_repository.dart';

// VIX: Visual Interaction Systems Corp. 2021
// Mobile Framework
// BLoC Business Logic Component

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;

  // Registra el Repositorio central de la app y setea el estado Inicial
  AuthBloc(this.authRepo) : super(InitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // this is where the events are handled, if you want to call a method
    // you can yield* instead of the yield, but make sure your
    // method signature returns Stream<NavDrawerState> and is async*

    /*if (event is NavigateTo) {
      // only route to a new location if the new location is different
      //if (event.destinationState != state.currentState) {
      //yield AppState(event.destinationState);
      yield Logged();
      //}
    } else 
    */
    if (event is AuthStart) {
      print('Auth BLOC : Inicia Autenticación');
      print('Auth BLOC : Leyendo Datos Locales');

      var userCredentials = await authRepo.readLocalUserCredentials();

      if (userCredentials.get('idToken') == null) {
        print('BLOC: No hay usuario registrado');
        yield NotLogged();
      } else {
        var nombre = userCredentials.get('email');
        print('Auth BLOC: Usuario Registrado: $nombre');
        yield Logged(user: userCredentials.get('email'));
      }
    } else if (event is AttemptToLogin) {
      var loginResult = await authRepo.login(event.userCredentials);
      if (loginResult['status'] == true) {
        yield Logged(user: loginResult['user'].get('email'));
      } else {
        yield LoginFailed(loginResult['message']['message']);
      }
    } else if (event is AttemptToLogOut) {
      await authRepo.clearLocalUser();
      yield NotLogged();
    } else if (event is GoToRegister) {
      yield NotRegistered();
    } else if (event is AttemptToRegister) {
      var registerResult = await authRepo.register(event.userCredentials);
      if (registerResult['status'] == true) {
        yield Logged(user: registerResult['user'].get('email'));
      } else {
        yield RegisterFailed(registerResult['message']['message']);
      }
    } else if (event is GoToLogin) {
      yield NotLogged();
    }
  }
}
