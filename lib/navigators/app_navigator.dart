import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/app_bloc.dart';
import 'package:vix_roader/states/app_states.dart';
import 'package:vix_roader/screens/appScreens/option1_view.dart';
import 'package:vix_roader/screens/appScreens/option2_view.dart';
import 'package:vix_roader/screens/appScreens/profile_view.dart';
import 'package:vix_roader/screens/appScreens/profile_edit_view.dart';

import 'package:vix_roader/screens/appScreens/welcome_view.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is AppState0) MaterialPage(child: WelcomeView()),
          if (state is ProfileViewState) MaterialPage(child: ProfileView()),
          if (state is ProfileEditState) MaterialPage(child: ProfileEditView()),
          if (state is AppState1) MaterialPage(child: Option1()),
          if (state is AppState2) MaterialPage(child: Option2()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
