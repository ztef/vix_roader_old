import 'package:bloc/bloc.dart';
import 'package:vix_roader/events/app_events.dart';
import 'package:vix_roader/states/app_states.dart';
import 'package:vix_roader/repositories/app_repository.dart';

// VIX: Visual Interaction Systems Corp. 2021
// Mobile Framework
// BLoC Business Logic Component

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository appRepo;

  // Registra el Repositorio central de la app y setea el estado Inicial
  AppBloc(this.appRepo) : super(LoadingData());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is StartingApp) {
      print('APP BLOC : Inicia Aplicacion');
      print('APP BLOC : Leyendo Datos Locales');

      var userData = await appRepo.readLocalUserData();
      if (userData.get('name') == '') {
        print('APP BLOC: No hay datos locales. Creando Registro');

        var result = await appRepo.createLocalUserData();
        if (result) {
          yield AppState0();
        }
      } else {
        var nombre = userData.get('name');
        print('APP BLOC: Datos de Usuario Locales de : $nombre');
        yield AppState0();
      }
    } else if (event is AttemptToGetUser) {
      /*var getResult = await appRepo.getUser();
      if (getResult['status'] == true) {
        yield (AppState0());
      } else {
        yield (AppState0());
      }
      */
    } else if (event is NavigateTo) {
      yield (event.destinationState);
    }
  }
}
