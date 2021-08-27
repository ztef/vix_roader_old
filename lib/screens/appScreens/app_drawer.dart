import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/app_bloc.dart';
import 'package:vix_roader/events/app_events.dart';
import 'package:vix_roader/states/app_states.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            padding: EdgeInsets.zero,
            child: Column(children: <Widget>[
              Expanded(
                  child: Column(children: <Widget>[
                _createHeader(),
                _createDrawerItem(
                    icon: Icons.account_box,
                    text: 'Mi Perfil',
                    onTap: () => BlocProvider.of<AppBloc>(context)
                        .add(NavigateTo(ProfileViewState()))),
                _createDrawerItem(
                    icon: Icons.travel_explore, text: 'Mis Viajes'),
                _createDrawerItem(
                    icon: Icons.calendar_view_month,
                    text: 'Mi Bitacora',
                    onTap: () => BlocProvider.of<AppBloc>(context)
                        .add(NavigateTo(AppState2()))),
                Divider(),
                _createDrawerItem(icon: Icons.add_location, text: 'Alertas'),
                _createDrawerItem(icon: Icons.exit_to_app, text: 'Salir'),
                Divider(),
                Container(
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Column(
                          children: <Widget>[
                            Divider(),
                            ListTile(
                                leading: Icon(Icons.settings),
                                title: Text('Configuración')),
                            ListTile(
                                leading: Icon(Icons.help),
                                title: Text('Acerca de'))
                          ],
                        ))),
              ]))
            ])));
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/drawer_header_background.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 30.0,
              left: 16.0,
              child: Text("Viusal Roader",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Bitácora Electrónica",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontWeight: FontWeight.normal))),
        ]));
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
