import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vix_roader/repositories/remote_repository.dart';
import 'package:vix_roader/repositories/local_repository.dart';
import 'package:vix_roader/domain/domain_objects.dart';

class AppRepository {
  late UserData userData;
  late TripStatus tripStatus;

  List tripLogDB = [];

  RemoteRepository remoteRepo = new RemoteRepository();
  LocalRepository localRepo = new LocalRepository();

  getUserDataObject() {
    return userData;
  }

  Future<bool> updateUserData(data) async {
    // Incorpora datos a objeto local en memoria
    userData.updateRecord(data);
    // Intenta Peristir Localmente
    var result = await localRepo.saveLocalObject(userData);
    if (result) {
      result = await remoteRepo.updateRecord(userData);
    }

    return result;
  }

  Future<bool> getCatalogs() async {
    // Intenta Leer Catalogos de la Aplicación

    List<dynamic> catalogs = await remoteRepo.getCatalogs();

    // Procesa cada Catálogo :
    catalogs.forEach((element) {
      var documentName = element['document'];
      var documentData = element['collections'];

      // Guarda localmente cada catalogo
      localRepo.storeCatalog(documentName, documentData);
    });

    var result = true;

    return result;
  }

  Future<UserData> readLocalUserData() async {
    UserData localUserData =
        await localRepo.getLocalObject("user_data") as UserData;
    this.userData = localUserData;
    return localUserData;
  }

  Future<TripStatus> readLocalTripStatus() async {
    TripStatus localTripStatus =
        await localRepo.getLocalObject("trip_status") as TripStatus;
    this.tripStatus = localTripStatus;
    return localTripStatus;
  }

  Future<void> readLocalTripLogDB() async {
    // Solamente Lee la BD si está vacio
    if (tripLogDB.length == 0) {
      var tripId = tripStatus.get('tripCounter');
      var tripLogRaw = await localRepo.getLocalLogDB(tripId);
      print(tripLogRaw);
      tripLogDB = tripLogRaw;
    }
  }

  Future<TripStatus> saveLocalTripStatus(newTripStatus) async {
    this.tripStatus = newTripStatus;
    await localRepo.saveLocalObject(this.tripStatus);

    return this.tripStatus;
  }

  Future<void> tripLog(logData) async {
    var timeStamp = DateTime.now();
    var logEntry = {'timeStamp': timeStamp, 'data': logData};

    // Agrega en Memoria.
    tripLogDB.add(logEntry);

    // Persiste en localStorage :
    await localRepo.saveLocalLogObject(logEntry);
  }

  // Regresa log del vieje actual
  getTripLog() {
    var tripId = tripStatus.get('tripCounter');
    List thisTrip = [];
    tripLogDB.forEach((element) {
      if (element['data']['tripId'] == tripId) {
        thisTrip.add(element);
      }
    });
    return thisTrip;
  }

  sort(Map map) {
    Map newmap = {};
    for (int i = 0; i < map.length; i++) {
      var k = map.entries.last.key;
      var y = map.entries.last.value;
      newmap[k] = y;
      map.remove(k);
    }
    return newmap;
  }

  Future<bool> createLocalTripStatus() async {
    // Lee las credenciales del usuario almacenadas localmente
    UserCredentials localUserCredentials =
        await localRepo.getLocalObject("user_credentials") as UserCredentials;
    var email = localUserCredentials.get('email');

    tripStatus.set('email', email);
    tripStatus.set('onTravel', false);
    tripStatus.set('available', false);
    tripStatus.set('tripStatus', 'paused');
    tripStatus.set('tripCounter', 0);

    var result = await localRepo.saveLocalObject(tripStatus);
    return result;
  }

  Future<bool> createLocalUserData() async {
    // Lee las credenciales del usuario almacenadas localmente
    UserCredentials localUserCredentials =
        await localRepo.getLocalObject("user_credentials") as UserCredentials;
    var email = localUserCredentials.get('email');
    var localId = localUserCredentials.get('localId');

    userData.set('email', email);
    userData.set('localId', localId);
    userData.set('name', email);
    userData.set('phone', '');

    var result = await localRepo.saveLocalObject(userData);
    return result;
  }

  static Future<FileImage> getLocalImage() async {
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

    return fi;
  }

  static Future<void> saveLocalImage(XFile image) async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/foto.jpg'; // 3

    return image.saveTo(filePath);
  }

  static Future<Directory> _getAppDirectory() async {
    var appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    return appDocumentsDirectory;
  }
}
