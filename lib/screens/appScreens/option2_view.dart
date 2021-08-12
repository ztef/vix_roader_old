import 'package:flutter/material.dart';
import 'package:vix_m/screens/appScreens/app_drawer.dart';

class Option2 extends StatelessWidget {
  static const String routeName = '/option1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OPCION 2'),
      ),
      drawer: Drawer(child: AppDrawer() // Populate the Drawer in the next step.
          ),
      body: Center(
        child: Text('Opcion 2'),
      ),
    );
  }
}
