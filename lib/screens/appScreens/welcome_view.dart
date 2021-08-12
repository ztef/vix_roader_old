import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/auth_bloc.dart';
import 'package:vix_roader/events/auth_events.dart';
import 'package:vix_roader/screens/appScreens/app_drawer.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WELCOME'),
        ),
        drawer:
            Drawer(child: AppDrawer() // Populate the Drawer in the next step.
                ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Bienvenido '),
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AttemptToLogOut());
              },
            ),
          ]),
        ));
  }
}
