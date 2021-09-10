import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/op_bloc.dart';
import 'package:vix_roader/events/op_events.dart';
import 'package:vix_roader/screens/appScreens/trip_data_view.dart';
import 'package:vix_roader/states/op_states.dart';
import 'package:vix_roader/repositories/app_repository.dart';
import 'package:vix_roader/screens/appScreens/app_drawer.dart';
import 'package:vix_roader/widgets/box_container_widget.dart';
import 'package:vix_roader/widgets/form_widgets.dart';
import 'package:vix_roader/widgets/profile_photo_widget.dart';
import 'package:vix_roader/widgets/user_data_widget.dart';
import 'package:vix_roader/widgets/user_status_widget.dart';

// Operations View
class OpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpBloc, OpState>(builder: (context, state) {
      return OpPanel(state);
    });
  }
}

class OpPanel extends StatelessWidget {
  final state;
  OpPanel(this.state) : super();

  @override
  Widget build(BuildContext context) {
    var userData =
        RepositoryProvider.of<AppRepository>(context).getUserDataObject();

    return Scaffold(
      appBar: AppBar(
        title: Text('BIENVENIDO'),
      ),
      drawer: Drawer(child: AppDrawer()),
      body: Center(
        child: Column(children: [
          // Foto del Profile
          ProfilePhotoWidget(imagePath: 'foto.jpg', isEdit: false, bloc: null),
          // Nombre del Usuario
          userDataWidget(userData),

          // Tarjeta de Estado : En Viaje/No en Viaje.
          userStatusWidget(state: state),

          // Tarjeta de Estadísticas
          boxContainer(
              Text('Viajes Registrados : 32 , Horas de conducción : 245')),
        ]),
      ),
      floatingActionButton: _nextAction(context, state),
    );
  }
}

_nextAction(context, state) {
  if (state is IdleState) {
    return FloatingActionButton.extended(
        onPressed: () => {
              modalFullScreen(context, BlocProvider.of<OpBloc>(context))
              //BlocProvider.of<OpBloc>(context).add(StartTrip())
            },
        label: Text('Iniciar Viaje'),
        icon: Icon(Icons.navigation));
  } else if (state is TravelState) {
    return FloatingActionButton.extended(
        onPressed: () => {BlocProvider.of<OpBloc>(context).add(StopTrip())},
        label: Text('Detener Viaje'),
        icon: Icon(Icons.navigation));
  }
}
