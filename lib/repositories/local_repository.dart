import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:vix_roader/domain/generic_domain_object.dart';
//import 'package:vix_roader/domain/domain_objects.dart';

class LocalRepository {
  Future<bool> saveLocalObject(GenericDomainObject localObject) async {
    final SharedPreferences? prefs = await SharedPreferences.getInstance();

    bool opStatus;

    opStatus = (await prefs?.setString(
        localObject.objectId, json.encode(localObject.toJson())))!;

    print("LOCAL_REPO: Guardando Objeto ");
    print(localObject);

    return opStatus;
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
}

mixin Dynamic {}
