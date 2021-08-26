import 'package:vix_roader/domain/generic_domain_object.dart';
import 'package:vix_roader/repositories/auth_url.dart';
import 'package:vix_roader/domain/domain_objects.dart';
import 'package:http/http.dart';
import 'dart:convert';

class RemoteAuthRepository {
  Future<Map<String, dynamic>> login(authCredentials) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': authCredentials['user'],
      'password': authCredentials['password'],
      'returnSecureToken': 'true'
    };

    Response response = await post(
      Uri.parse(AuthUrl.login),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData;

      UserCredentials authUser = GenericDomainObject.fromType(
              {'objectId': 'user_credentials', 'payLoad': userData})
          as UserCredentials;

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(authCredentials) async {
    var result;
    final Map<String, dynamic> registrationData = {
      'email': authCredentials['user'],
      'password': authCredentials['password'],
      'returnSecureToken': 'true'
    };

    Response response = await post(
      Uri.parse(AuthUrl.register),
      body: json.encode(registrationData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData;

      UserCredentials authUser = GenericDomainObject.fromType(
              {'objectId': 'user_credentials', 'payLoad': userData})
          as UserCredentials;

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }
}
