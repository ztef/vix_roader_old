import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/app_bloc.dart';
import 'package:vix_roader/events/app_events.dart';
import 'package:vix_roader/states/app_states.dart';

import 'package:vix_roader/screens/appScreens/app_drawer.dart';
import 'package:vix_roader/widgets/photo_widget.dart';

import 'package:vix_roader/repositories/app_repository.dart';
import 'package:vix_roader/domain/domain_objects.dart';
import 'package:vix_roader/widgets/numbers_widget.dart';
import 'package:vix_roader/widgets/button_widget.dart';
import 'package:vix_roader/widgets/user_data_widget.dart';

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
        //ProfilePhotoWidget(imagePath: 'foto.jpg', isEdit: false, bloc: null),

        photoWidget(context, false, null),

        const SizedBox(height: 24),
        userDataWidget(user),

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
