import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/auth_bloc.dart';
import 'package:vix_roader/events/auth_events.dart';
import 'package:vix_roader/repositories/app_repository.dart';
import 'package:vix_roader/screens/appScreens/app_drawer.dart';

class QuitView extends StatelessWidget {
  QuitView() : super();

  @override
  Widget build(BuildContext context) {
    var username = '';

    username = RepositoryProvider.of<AppRepository>(context)
        .getUserDataObject()
        .get('name');
    return Scaffold(
        appBar: AppBar(
          title: Text('SALIR'),
        ),
        drawer: Drawer(child: AppDrawer()),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Gracias $username'),
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
