import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_m/bloc/app_bloc.dart';
import 'package:vix_m/states/app_states.dart';
import 'package:vix_m/screens/appScreens/option1_view.dart';
import 'package:vix_m/screens/appScreens/option2_view.dart';
import 'package:vix_m/screens/appScreens/profile_view.dart';
import 'package:vix_m/screens/appScreens/welcome_view.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is AppState0) MaterialPage(child: WelcomeView()),
          if (state is AppState1) MaterialPage(child: Option1()),
          if (state is AppState2) MaterialPage(child: Option2()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
