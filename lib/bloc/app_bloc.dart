import 'package:bloc/bloc.dart';
import 'package:vix_m/events/app_events.dart';
import 'package:vix_m/states/app_states.dart';
import 'package:vix_m/repositories/app_repository.dart';

// VIX: Visual Interaction Systems Corp. 2021
// Mobile Framework
// BLoC Business Logic Component

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository appRepo;

  // Registra el Repositorio central de la app y setea el estado Inicial
  AppBloc(this.appRepo) : super(InitialState());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    // this is where the events are handled, if you want to call a method
    // you can yield* instead of the yield, but make sure your
    // method signature returns Stream<NavDrawerState> and is async*

    if (event is NavigateTo) {
      // only route to a new location if the new location is different
      //if (event.destinationState != state.currentState) {
      //yield AppState(event.destinationState);
      yield Logged();
      //}
    } else if (event is AppStarted) {
      print('BLOC : Inicia Aplicacion');
      print('BLOC : Leyendo Datos Locales');

      final String user = await appRepo.readLocalUser();

      if (user == '') {
        yield NotLogged();
      } else {
        yield Logged(user: user);
      }
    } else if (event is AttemptToLogin) {
      var loginResult = await appRepo.login(event.userCredentials);
      if (loginResult['status'] == true) {
        yield Logged(user: loginResult['user'].email);
      } else {
        yield NotLogged();
      }
    } else if (event is AttemptToLogOut) {
      yield NotLogged();
    }
  }
}
