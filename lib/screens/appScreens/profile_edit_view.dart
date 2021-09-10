import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vix_roader/events/profile_events.dart';
import 'package:vix_roader/screens/appScreens/app_drawer.dart';
import 'package:vix_roader/bloc/profile_bloc.dart';
import 'package:vix_roader/bloc/app_bloc.dart';
import 'package:vix_roader/states/profile_states.dart';
import 'package:vix_roader/states/app_states.dart';
import 'package:vix_roader/events/app_events.dart';
import 'package:vix_roader/widgets/form_widgets.dart';
import 'package:vix_roader/widgets/profile_photo_widget.dart';

class ProfileEditView extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Mi Perfil '),
        ),
        drawer: Drawer(child: AppDrawer()),
        body: ListView(children: [
          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if ((state is NewPhoto) || (state is EditState)) {
              return (ProfilePhotoWidget(
                imagePath: 'foto.jpg',
                isEdit: true,
                bloc: bloc,
                /*
                onClicked: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return photoDialog(context, bloc);
                      });
                },
                */
              ));
            } else
              return Container();
          }),
          FormBuilder(
            key: _formKey,
            initialValue: bloc.getInitialValues(),
            child: Column(
              children: <Widget>[
                //_imageFieldWidget(context, 'foto'),
                textFieldWidget(
                    context, 'name', 'Nombre Completo', TextInputType.name),
                textFieldWidget(
                    context, 'phone', 'Teléfono', TextInputType.phone),
                //         _dateFieldWidget(context, 'birth'),
                //         _checkBoxFieldWidget(context, 'terms'),
                //         _imageFieldWidget(context, 'photo'),

                BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                  if ((state is NewPhoto) || (state is EditState)) {
                    return submitButtonWidget('Guardar', context, _formKey,
                        (data) => {bloc.add(AttemptToUpdate(data))});
                  } else if (state is AttemptingToUpdate)
                    return CircularProgressIndicator();
                  else if (state is Updated) {
                    return _okDialog(context);
                  } else {
                    return _okDialog(context);
                  }
                }),

                SizedBox(height: 20),
                _resetButtonWidget(context, _formKey),
              ],
            ),
          )
        ]));
  }

  Widget _dateFieldWidget(context, _fieldName) {
    return FormBuilderDateTimePicker(
      name: _fieldName,
      // onChanged: _onChanged,
      inputType: InputType.date,
      decoration: InputDecoration(
        labelText: 'Fecha de Nacimiento',
      ),
      //initialTime: TimeOfDay(hour: 8, minute: 0),
      initialValue: DateTime.now(),
      enabled: true,
    );
  }

  Widget _okDialog(context) {
    final bloc = BlocProvider.of<AppBloc>(context);

    return AlertDialog(
      title: new Text('Registro Guardado'),
      content: new Text('Sus datos han sido Enviados'),
      actions: <Widget>[
        new TextButton(
          child: new Text('OK'),
          onPressed: () {
            bloc.add(NavigateTo(ProfileViewState()));
          },
        )
      ],
    );
  }
}

Widget _resetButtonWidget(context, _formKey) {
  return ElevatedButton(
    onPressed: () {
      // Reset form
      _formKey.currentState!.reset();

      // Optional: unfocus keyboard
      FocusScope.of(context).unfocus();
    },
    child: Text('Reset'),
  );
}
