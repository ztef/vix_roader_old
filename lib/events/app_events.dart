import 'package:vix_m/states/app_states.dart';

abstract class AppEvent {
  const AppEvent();
}

class NavigateTo extends AppEvent {
  final AppState destinationState;
  const NavigateTo(this.destinationState);
}

class AppStart extends AppEvent {}

class AppEvent0 extends AppEvent {}

class AppEvent1 extends AppEvent {}

class AppEvent2 extends AppEvent {}
