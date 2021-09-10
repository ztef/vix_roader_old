import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/op_bloc.dart';
import 'package:vix_roader/events/op_events.dart';
import 'package:vix_roader/repositories/app_repository.dart';
import 'package:vix_roader/screens/appScreens/op_view.dart';

class OpWrapper extends StatelessWidget {
  OpWrapper() : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OpBloc(
        context.read<AppRepository>(),
      )..add(StartingOp()),
      child: OpView(),
    );
  }
}
