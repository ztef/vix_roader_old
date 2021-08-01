import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_m/bloc/app_bloc.dart';
import 'package:vix_m/states/app_states.dart';
import 'package:vix_m/screens/authScreens/login_view.dart';
import 'package:vix_m/screens/authScreens/signup_view.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show login
          if (state.currentState == LocalState.state0)
            MaterialPage(child: LoginView()),

          // Show confirm sign up
          if (state.currentState == LocalState.state1)
            MaterialPage(child: SignUpView())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
