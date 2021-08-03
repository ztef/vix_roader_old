import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_m/bloc/app_bloc.dart';
import 'package:vix_m/navigators/app_navigator.dart';
import 'package:vix_m/repositories/app_repository.dart';
import 'package:vix_m/events/app_events.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AppRepository()),
      ],
      child: BlocProvider(
        create: (context) => AppBloc(
          context.read<AppRepository>(),
        )..add(AppStarted()),
        child: AppNavigator(),
      ),
    ));
  }
}
