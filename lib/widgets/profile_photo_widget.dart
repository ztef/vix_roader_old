import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:vix_roader/events/profile_events.dart';
import 'package:vix_roader/repositories/app_repository.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final String? imagePath;
  final bool isEdit;
  //final VoidCallback onClicked;
  final bloc;

  const ProfilePhotoWidget({
    Key? key,
    required this.imagePath,
    required this.isEdit,
    //required this.onClicked,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: isEdit ? buildEditIcon(color, context) : Container(),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    Future<FileImage> image = AppRepository.getLocalImage();

    return ClipOval(
        child: Material(
      //color: (image.url == "") ? Colors.black : Colors.transparent,
      color: Colors.transparent,
      child: FutureBuilder(
        future: image,
        builder: (BuildContext context, AsyncSnapshot<FileImage> image) {
          if (image.hasData) {
            return Ink.image(
              ///data/user/0/com.example.vix_roader/app_flutter/foto.jpg
              image: image.data!,
              key: UniqueKey(),
              fit: BoxFit.cover,
              width: 128,
              height: 128,
            );
          } else {
            return new Container();
          }
        },
      ),
    ));
  }

  Widget buildEditIcon(Color color, context) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 4,
          child: IconButton(
            icon: const Icon(Icons.add_a_photo, color: Colors.white, size: 20),
            tooltip: 'Cambiar Foto de Perfil',
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return photoDialog(context, bloc);
                },
              );
            },
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

SimpleDialog photoDialog(context, bloc) {
  return SimpleDialog(title: Text("Tomar Fotografía"), children: <Widget>[
    SimpleDialogOption(
      onPressed: () async {
        Navigator.pop(context); //close the dialog box
        _pickImage(ImageSource.gallery, bloc);
      },
      child: const Text('Seleccionar de Galería'),
    ),
    SimpleDialogOption(
      onPressed: () async {
        Navigator.pop(context); //close the dialog box
        _pickImage(ImageSource.camera, bloc);
      },
      child: const Text('Tomar Foto Nueva'),
    ),
  ]);
}

_pickImage(ImageSource src, bloc) async {
  final _picker = ImagePicker();

  var img = await _picker.pickImage(source: src);
  print('GUARDADO DE FOTO');
  print(img!.path);

  AppRepository.saveLocalImage(img).then((value) => bloc.add(LoadNewPhoto()));
}
