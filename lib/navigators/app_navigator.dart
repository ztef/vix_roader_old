import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/app_bloc.dart';
import 'package:vix_roader/states/app_states.dart';
import 'package:vix_roader/screens/appScreens/history_view.dart';
import 'package:vix_roader/screens/appScreens/option2_view.dart';
import 'package:vix_roader/screens/appScreens/quit_view.dart';
import 'package:vix_roader/screens/appScreens/profile_view.dart';
import 'package:vix_roader/navigators/profile_navigator.dart';
import 'package:vix_roader/screens/appScreens/app_loading.dart';
import 'package:vix_roader/navigators/op_wrapper.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is LoadingData) MaterialPage(child: LoadingView()),
          if (state is HomeState) MaterialPage(child: OpWrapper()),
          if (state is ProfileViewState) MaterialPage(child: ProfileView()),
          if (state is ProfileEditState) MaterialPage(child: ProfileWrapper()),
          if (state is HistoryViewState) MaterialPage(child: HistoryView()),
          if (state is AppState2) MaterialPage(child: Option2()),
          if (state is QuitState) MaterialPage(child: QuitView()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
