import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/app_bloc.dart';
import 'package:vix_roader/events/app_events.dart';
import 'package:vix_roader/states/app_states.dart';

import 'package:vix_roader/screens/appScreens/app_drawer.dart';
import 'package:vix_roader/widgets/profile_widget.dart';
import 'package:vix_roader/repositories/app_repository.dart';
import 'package:vix_roader/domain/domain_objects.dart';
import 'package:vix_roader/widgets/numbers_widget.dart';
import 'package:vix_roader/widgets/button_widget.dart';

class ProfileView extends StatelessWidget {
  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    UserData user;
    user = RepositoryProvider.of<AppRepository>(context).getUserDataObject();

    return Scaffold(
      appBar: AppBar(
        title: Text('MI PERFIL'),
      ),
      drawer: Drawer(child: AppDrawer() // Populate the Drawer in the next step.
          ),
      body: ListView(children: [
        ProfileWidget(imagePath: user.get('imagePath'), onClicked: () {}),
        const SizedBox(height: 24),
        buildName(user),
        const SizedBox(height: 24),
        Center(child: buildUpdateButton(context)),
        const SizedBox(height: 24),
        NumbersWidget(),
        const SizedBox(height: 48),
        buildAbout(user),
      ]),
    );
  }
}

Widget buildName(UserData user) => Column(
      children: [
        Text(
          user.get('name')!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.get('email')!,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );

Widget buildUpdateButton(context) => ButtonWidget(
      text: 'Actualizar Perfil',
      onClicked: () {
        BlocProvider.of<AppBloc>(context).add(NavigateTo(ProfileEditState()));
      },
    );

Widget buildAbout(UserData user) => Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mis Datos :',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            user.get('about')!,
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
