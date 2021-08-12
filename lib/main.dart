import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/auth_bloc.dart';
import 'package:vix_roader/navigators/auth_navigator.dart';
import 'package:vix_roader/repositories/auth_repository.dart';
import 'package:vix_roader/events/auth_events.dart';

/*
     Visual Interaction Systems Corp
     vix_roader
     App para manejar bitácoras de transporte 


*/
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
        RepositoryProvider(create: (context) => AuthRepository()),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(
          context.read<AuthRepository>(),
        )..add(AuthStart()),
        child: AuthNavigator(),
      ),
    ));
  }
}
