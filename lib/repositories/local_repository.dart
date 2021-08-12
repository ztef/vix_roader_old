import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:vix_roader/domain/user.dart';

class LocalRepository {
  Future<User> saveUser(User user) async {
    final SharedPreferences? prefs = await SharedPreferences.getInstance();

    prefs?.setString("userId", user.userId!);
    prefs?.setString("name", user.name!);
    prefs?.setString("email", user.email!);
    prefs?.setString("phone", user.phone!);
    prefs?.setString("type", "");
    prefs?.setString("token", user.token!);
    prefs?.setString("renewalToken", user.renewalToken!);

    print("LOCAL_REPO: Guardando Usuario ");
    print(user.email);

    return user;
  }

  Future<User> getUser() async {
    final SharedPreferences? prefs = await SharedPreferences.getInstance();

    String? userId = prefs?.getString("userId");
    String? name = prefs?.getString("name");
    String? email = prefs?.getString("email");
    String? phone = prefs?.getString("phone");
    String? type = prefs?.getString("type");
    String? token = prefs?.getString("token");
    String? renewalToken = prefs?.getString("renewalToken");

    return User(
        userId: userId,
        name: name,
        email: email,
        phone: phone,
        type: type,
        token: token,
        renewalToken: renewalToken);
  }

  Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("type");
    prefs.remove("token");

    return true;
  }

  Future<String?> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }
}
