import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class ProfileWidget extends StatelessWidget {
  final String? imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
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
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    Future<FileImage> image = _getImage();

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
              child: InkWell(onTap: onClicked),
            );
          } else {
            return new Container();
          }
        },
      ),
    ));
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
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

Future<FileImage> _getImage() async {
  imageCache?.clear();

  Directory appDir = await _getAppDirectory();
  String appDocumentsPath = appDir.path; // 2
  String filePath = '$appDocumentsPath/foto.jpg'; // 3
  var imageFile = File(filePath);

  if (await File(filePath).exists()) {
    print("File exists");
  } else {
    print("File don't exists");
  }

  FileImage fi = FileImage(imageFile);

  //fi.evict();

  return fi;
}

Future<Directory> _getAppDirectory() async {
  var appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
  return appDocumentsDirectory;
}
