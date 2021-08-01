import 'package:vix_m/states/app_states.dart';

abstract class AppEvent {
  const AppEvent();
}

class NavigateTo extends AppEvent {
  final LocalState destinationState;
  const NavigateTo(this.destinationState);
}
