import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_m/bloc/app_bloc.dart';
import 'package:vix_m/events/app_events.dart';
import 'package:vix_m/states/app_states.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGNUP'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to PageA'),
          onPressed: () {
            BlocProvider.of<AppBloc>(context)
                .add(NavigateTo(LocalState.state0));
          },
        ),
      ),
    );
  }
}
