import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:vix_roader/domain/generic_domain_object.dart';
//import 'package:vix_roader/domain/domain_objects.dart';

class LocalRepository {
  late String logFileName;
  late String historyFileName;

  Future<bool> saveLocalObject(GenericDomainObject localObject) async {
    final SharedPreferences? prefs = await SharedPreferences.getInstance();

    bool opStatus;
    var js = localObject.toJson();
    opStatus = (await prefs?.setString(
        localObject.objectId,
        json.encode(js, toEncodable: (v) {
          if (v is File) {
            return {};
          } else
            return v.toJson();
        })))!;

    print("LOCAL_REPO: Guardando Objeto ");
    print(localObject);

    return opStatus;
  }

  // Agrega un record a fileName
  Future<void> appendPersistedLocalObject(record, fileName) async {
    var targetFile = await getFilePath(fileName);

    appendRecord2File(
        json.encode(record, toEncodable: myDateSerializer), targetFile);
  }

  dynamic myDateSerializer(dynamic object) {
    if ((object is DateTime) || (object is Duration)) {
      return object.toString();
    } else
      return object;
  }

  Future getLocalHistoryDB(fileName) async {
    var db = [];

    var targetFileName = await getFilePath(fileName);
    if (await File(targetFileName).exists()) {
      var rawData = await readFile(targetFileName);
      db = json.decode('[' + rawData.replaceFirst(",", "") + "]",
          reviver: (k, v) {
        if (k == 'timeStamp') return DateTime.parse(v as String);
        if (k == 'driveTime') return parseDuration(v as String);
        if (k == 'pauseTime') return parseDuration(v as String);

        return v;
      });
      // Deja pasar solo los Entries con tripID

    }

    // Procesa y Filtra

    return db;
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  // Lee archivo de logs (logFile.txt) y restaura solo
  // los eventos del tripId
  Future getLocalLogDB(tripId, fileName) async {
    var db = [];
    List thisTrip = [];

    logFileName = await getFilePath(fileName);
    if (await File(logFileName).exists()) {
      var rawData = await readFile(logFileName);
      db = json.decode('[' + rawData.replaceFirst(",", "") + "]",
          reviver: (k, v) {
        if (k == 'timeStamp') return DateTime.parse(v as String);
        return v;
      });
      // Deja pasar solo los Entries con tripID

      db.forEach((element) {
        if (element['data']['tripId'] == tripId) {
          thisTrip.add(element);
        }
      });
    }

    // Procesa y Filtra

    return thisTrip;
  }

  Future getLocalObject(objectId) async {
    final SharedPreferences? prefs = await SharedPreferences.getInstance();

    String? data = prefs!.getString(objectId);
    var payload;

    if (data == null) {
      payload = {};
    } else {
      payload = json.decode(data)['payLoad'];
    }

    var localObject = GenericDomainObject.fromType(
        {'objectId': objectId, 'payLoad': payload});

    return localObject;
  }

  Future<bool> removeLocalObject(objectId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(objectId);

    return true;
  }

  /*
     Los Catalogos son documentos que pueden contener varias colecciones dentro.
     la coleccion tipo lista contiene los elementos del catálogo desplegables
     por el UI.
 */
  Future<bool> storeCatalog(catalogId, contents) async {
    final SharedPreferences? prefs = await SharedPreferences.getInstance();

    bool opStatus;

    var listPosition =
        contents.indexWhere((document) => document['collection'] == 'list');
    List catalogItems = contents[listPosition]['documents'];
    List<String> items = [];

    catalogItems.forEach((element) {
      var id = element['document'];
      var desc = element['data']['desc'];
      items.add(desc);
    });

    opStatus = (await prefs?.setStringList(catalogId, items))!;

    print("LOCAL_REPO: Guardando Catalogo ");

    return opStatus;
  }

  // Funciones basicas de Archivo :

  Future<String> getFilePath(String fileName) async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/$fileName'; // 3
    return filePath;
  }

  void appendRecord2File(String record, _file) async {
    File file = File(_file); // 1
    file.writeAsString("," + record, mode: FileMode.writeOnlyAppend); // 2
  }

  Future<String> readFile(_file) async {
    File file = File(_file); // 1
    String fileContent = await file.readAsString(); // 2
    print('File Content: $fileContent');
    return fileContent;
  }
}

mixin Dynamic {}
