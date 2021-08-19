import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vix_roader/bloc/profile_bloc_stream_based.dart';
import 'package:vix_roader/screens/appScreens/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ProfileBloc(),
      child: ProfileForm(),
    );
  }
}

class ProfileForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ProfileBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editando '),
      ),
      drawer: Drawer(child: AppDrawer() // Populate the Drawer in the next step.
          ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            userName(bloc),
            userPhone(bloc),
            SizedBox(
              height: 15.0,
            ),
            saveButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget userName(ProfileBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.userName,
        builder: (context, snapshot) {
          return TextFormField(
            initialValue: bloc.getUserName(),
            decoration: InputDecoration(
                labelText: 'Nombre Completo',
                errorText: snapshot.error.toString()),
            onChanged: bloc.changeUserName,
          );
        });
  }

  Widget userPhone(ProfileBloc bloc) {
    return StreamBuilder<double>(
        stream: bloc.userPhone,
        builder: (context, snapshot) {
          return TextField(
            decoration: InputDecoration(
                labelText: 'Teléfono', errorText: snapshot.error.toString()),
            onChanged: bloc.changeUserPhone,
          );
        });
  }

  Widget saveButton(ProfileBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.userValid,
        builder: (context, snapshot) {
          return ElevatedButton(
            child: Text('Guardar'),
            onPressed: !snapshot.hasData ? null : bloc.submitProfile,
          );
        });
  }
}
