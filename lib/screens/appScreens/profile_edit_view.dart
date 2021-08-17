import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/screens/appScreens/app_drawer.dart';
import 'package:vix_roader/repositories/app_repository.dart';
import 'package:vix_roader/domain/domain_objects.dart';
import 'package:vix_roader/widgets/profile_widget.dart';
import 'package:vix_roader/widgets/text_field_widget.dart';

class ProfileEditView extends StatefulWidget {
  @override
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  @override
  Widget build(BuildContext context) {
    UserData user = RepositoryProvider.of<AppRepository>(context).getUserData();

    return (Scaffold(
      appBar: AppBar(
        title: Text('EDITAR MI PERFIL'),
      ),
      drawer: Drawer(child: AppDrawer() // Populate the Drawer in the next step.
          ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.get('imagePath'),
            isEdit: true,
            onClicked: () async {
              final image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              if (image == null) return;

              final directory = await getApplicationDocumentsDirectory();
              final name = basename(image.path);
              final imageFile = File('${directory.path}/$name');
              final newImage = await File(image.path).copy(imageFile.path);

              user.set('imagePath', newImage.path);
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Nombre Completo',
            text: user.get('name')!,
            onChanged: (name) {
              user.set('name', name);
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Teléfono',
            text: user.get('phone')!,
            onChanged: (phone) {
              user.set('phone', phone);
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Fecha de Nacimiento',
            text: user.get('birth')!,
            onChanged: (birth) {
              user.set('birth', birth);
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: user.get('about')!,
            maxLines: 5,
            onChanged: (about) {
              user.set('abour', about);
            },
          ),
        ],
      ),
    ));
  }
}
