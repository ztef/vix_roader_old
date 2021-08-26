import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/profile_bloc.dart';
import 'package:vix_roader/states/profile_states.dart';
import 'package:vix_roader/events/profile_events.dart';
import 'package:vix_roader/repositories/app_repository.dart';
import 'package:vix_roader/screens/appScreens/profile_edit_view.dart';
//import 'package:vix_roader/screens/appScreens/profile_view.dart';
import 'package:vix_roader/screens/appScreens/app_loading.dart';

class ProfileWrapper extends StatelessWidget {
  late final initialValues;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc(
              context.read<AppRepository>(),
            )..add(LoadCatalogs()),
        child: ProfileNavigator());
  }
}

class ProfileNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is LoadingCatalogsState) MaterialPage(child: LoadingView()),
          if (state is EditState) MaterialPage(child: ProfileEditView()),
          if (state is AttemptingToUpdate) MaterialPage(child: LoadingView()),
          if (state is Updated) MaterialPage(child: ProfileEditView()),
          if (state is EditCompleted) MaterialPage(child: ProfileEditView()),
          if (state is ViewState) MaterialPage(child: ProfileEditView()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
