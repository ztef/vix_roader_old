import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CARGANDO DATOS ..'),
      ),
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
