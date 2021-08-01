import 'package:bloc/bloc.dart';
import 'package:vix_m/events/app_events.dart';
import 'package:vix_m/states/app_states.dart';
import 'package:vix_m/repositories/app_repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository appRepo;

  AppBloc(this.appRepo) : super(AppState(LocalState.state0));

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    // this is where the events are handled, if you want to call a method
    // you can yield* instead of the yield, but make sure your
    // method signature returns Stream<NavDrawerState> and is async*
    if (event is NavigateTo) {
      // only route to a new location if the new location is different
      if (event.destinationState != state.currentState) {
        yield AppState(event.destinationState);
      }
    }
  }
}
