import 'package:vix_roader/domain/generic_domain_object.dart';
import 'package:vix_roader/repositories/app_url.dart';
//import 'package:vix_roader/domain/domain_objects.dart';
import 'dart:io';

import 'package:http/http.dart';
import 'dart:convert';

class RemoteRepository {
  Future<bool> updateRecord(GenericDomainObject registro) async {
    bool result;

    final Map<String, dynamic> registrationData = registro.toJson();

    Response response = await post(
      Uri.parse(AppUrl.update),
      body: json.encode(registrationData, toEncodable: (v) {
        if (v is File)
          return {};
        else
          return v.toJson();
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['result'] == 'success')
        result = true;
      else
        result = false;
    } else
      result = false;

    return result;
  }

  Future<List<dynamic>> getCatalogs() async {
    var result = await getCollection('app_catalogs');
    return result;
  }

  Future<List<dynamic>> getCollection(collection) async {
    List<dynamic> documents = [{}];

    final Map<String, dynamic> query = {'collection': collection};

    Response response = await post(
      Uri.parse(AppUrl.getCollection),
      body: json.encode(query),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['result'] == 'success') {
        // Lee los documentos dentro de la colección.
        documents = responseData['data']['documents'];
      }
    }

    return documents;
  }
}
