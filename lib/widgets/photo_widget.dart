import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vix_roader/events/profile_events.dart';
import 'package:vix_roader/repositories/app_repository.dart';

Widget photoWidget(context, isEdit, bloc) {
  Future<Image> image = AppRepository.getLocalImage();

  return Center(
    child: Stack(
      children: [
        FutureBuilder(
            future: image,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return foto(snapshot.data);
              } else
                return Container();
            }),
        Positioned(
          bottom: 0,
          right: 0,
          child: isEdit ? buildEditIcon(context, bloc) : Container(),
        ),
      ],
    ),
  );
}

Widget foto(image) {
  return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      child: ClipOval(
        child: Material(
          color: Colors.black,
          child: image,
        ),
      ));
}

Widget buildEditIcon(context, bloc) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
          color: Colors.blue,
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
          )),
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
