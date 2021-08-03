import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_m/bloc/app_bloc.dart';
import 'package:vix_m/events/app_events.dart';
//import 'package:vix_m/states/app_states.dart';

class WelcomeView extends StatelessWidget {
  final String user;

  WelcomeView(this.user) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WELCOME'),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Bienvenido $user'),
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () {
                BlocProvider.of<AppBloc>(context).add(AttemptToLogOut());
              },
            ),
          ]),
        ));
  }
}
