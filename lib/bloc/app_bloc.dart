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
  AppBloc(this.appRepo) : super(AppState0());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppStart) {
      yield (AppState0());
    } else if (event is NavigateTo) {
      yield (event.destinationState);
    }
  }
}
