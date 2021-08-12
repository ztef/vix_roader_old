import 'package:flutter/material.dart';
import 'package:vix_roader/screens/appScreens/app_drawer.dart';

class Option1 extends StatelessWidget {
  static const String routeName = '/option1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OPCION 1'),
      ),
      drawer: Drawer(child: AppDrawer() // Populate the Drawer in the next step.
          ),
      body: Center(
        child: Text('Opcion 1'),
      ),
    );
  }
}
