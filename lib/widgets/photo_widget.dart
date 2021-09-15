import 'dart:io';

import 'package:flutter/material.dart';

Widget photoWidget() {
  var isEdit = true;

  Image image = Image.file(
    File('/data/user/0/com.example.vix_roader/app_flutter/foto.jpg'),
    width: 128,
    height: 128,
  );

  return Center(
    child: Stack(
      children: [
        foto(image),
        Positioned(
          bottom: 0,
          right: 0,
          child: isEdit ? buildEditIcon() : Container(),
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

Widget buildEditIcon() => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
          color: Colors.blue,
          all: 4,
          child: IconButton(
            icon: const Icon(Icons.add_a_photo, color: Colors.white, size: 20),
            tooltip: 'Cambiar Foto de Perfil',
            onPressed: () {
              print('');
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
