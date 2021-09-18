import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/op_bloc.dart';
import 'package:vix_roader/screens/appScreens/app_loading.dart';
import 'package:vix_roader/screens/appScreens/start_travel_view.dart';
import 'package:vix_roader/states/op_states.dart';
import 'package:vix_roader/screens/appScreens/app_drawer.dart';
import 'package:vix_roader/widgets/trip_history_widget.dart';
import 'package:vix_roader/widgets/trip_log_widget.dart';
import 'package:vix_roader/widgets/trip_stats_widget.dart';
import 'package:vix_roader/widgets/trip_status_widget.dart';
import 'package:vix_roader/widgets/user_status_widget.dart';

// Operations View
class OpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpBloc, OpState>(builder: (context, state) {
      return state is LoadingState ? LoadingView() : OpPanel(state);
    });
  }
}

class OpPanel extends StatelessWidget {
  final state;
  OpPanel(this.state) : super();

  @override
  Widget build(BuildContext context) {
    //var userData = RepositoryProvider.of<AppRepository>(context).getUserDataObject();

    return Scaffold(
      appBar: AppBar(
        title: Text('BITACORA DE VIAJE'),
      ),
      drawer: Drawer(child: AppDrawer()),
      body: Center(
        child: Column(children: [
          // Foto del Profile
          //ProfilePhotoWidget(imagePath: 'foto.jpg', isEdit: false, bloc: null),
          // Nombre del Usuario
          //userDataWidget(userData),

          // Tarjeta de Estado : En Viaje/No en Viaje.
          userStatusWidget(state: state),

          tripStatusWidget(
              context: context,
              state: state,
              bloc: BlocProvider.of<OpBloc>(context)),

          // Log del Viaje Actual
          (state is TravelState)
              ? tripLogWidget(
                  context: context,
                )
              : tripHistoryWidget(context: context),

          // Log

          Container(child: Text('')),

          // Estadísticas del Viaje Actual
          (state is TravelState)
              ? currentTripStatsWidget(
                  state: state,
                  context: context,
                )
              : Container(),
        ]),
      ),
      floatingActionButton: _nextAction(context, state),
    );
  }
}

_nextAction(context, state) {
  if (state is IdleState) {
    return FloatingActionButton.extended(
        onPressed: () => {modalFullScreen(context, startTravelDataDialog)},
        label: Text('Nuevo Viaje'),
        icon: Icon(Icons.navigation));
  } else if (state is TravelState) {
    return FloatingActionButton.extended(
        onPressed: () =>
            {stopTripDialog(context, BlocProvider.of<OpBloc>(context))},
        label: Text('Terminar el Viaje'),
        icon: Icon(Icons.navigation));
  }
}
