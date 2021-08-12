import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_m/bloc/app_bloc.dart';
import 'package:vix_m/events/app_events.dart';
import 'package:vix_m/navigators/app_navigator.dart';
import 'package:vix_m/repositories/app_repository.dart';

class AppWrapper extends StatelessWidget {
  AppWrapper() : super();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => AppRepository()),
        ],
        child: BlocProvider(
          create: (context) => AppBloc(
            context.read<AppRepository>(),
          )..add(AppStart()),
          child: AppNavigator(),
        ));
  }
}
