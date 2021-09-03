import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/auth_bloc.dart';
import 'package:vix_roader/events/auth_events.dart';
import 'package:vix_roader/repositories/app_repository.dart';
import 'package:vix_roader/screens/appScreens/app_drawer.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView() : super();

  @override
  Widget build(BuildContext context) {
    var username = '';

    username = RepositoryProvider.of<AppRepository>(context)
        .getUserDataObject()
        .get('name');
    return Scaffold(
      appBar: AppBar(
        title: Text('BIENVENIDO'),
      ),
      drawer: Drawer(child: AppDrawer()),
      body: Center(
        child: Column(children: [
          _createStatusItem(
              icon: Icons.supervised_user_circle, text: '$username'),
          boxContainer(Text('No estás de viaje')),
          boxContainer(
              Text('Viajes Registrados : 32 , Horas de conducción : 245')),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}

Widget _createStatusItem(
    {required IconData icon, required String text, GestureTapCallback? onTap}) {
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

Widget boxContainer(Widget w) {
  return Container(
    margin: const EdgeInsets.all(30.0),
    padding: const EdgeInsets.all(10.0),
    decoration: myBoxDecoration(), //       <--- BoxDecoration here
    child: w,
  );
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      width: 3.0,
      color: Colors.blue,
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(10.0) //         <--- border radius here
        ),
  );
}
