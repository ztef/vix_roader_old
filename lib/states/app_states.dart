//this is the state the user is expected to see
class AppState {
  final LocalState currentState;
  const AppState(this.currentState);
}

// helpful navigation pages, you can change
// them to support your pages
enum LocalState {
  state0,
  state1,
  state2,
  state3,
  state4,
  state5,
}
