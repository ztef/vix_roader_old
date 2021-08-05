import 'package:vix_m/repositories/remote_repository.dart';
import 'package:vix_m/repositories/local_repository.dart';
import 'package:vix_m/domain/user.dart';

class AppRepository {
  String user = "usuario";
  RemoteRepository remoteRepo = new RemoteRepository();
  LocalRepository localRepo = new LocalRepository();
  getUser() {
    return user;
  }

  setUser(String newuser) {
    user = newuser;
  }

  Future<User> readLocalUser() async {
    User localUser = await localRepo.getUser();
    return localUser;
  }

  Future<void> clearLocalUser() async {
    await localRepo.removeUser();
  }

  Future<dynamic> login(authCredentials) async {
    print('REPO: intentando login con $authCredentials');

    var loginResult = await remoteRepo.login(authCredentials);
    // Si el resultado es true, guarda credenciales en LocalRepository
    if (loginResult['status'] == true) {
      var storeResult = await localRepo.saveUser(loginResult['user']);
    } else {
      var storeResult = await localRepo.removeUser();
    }

    return loginResult;
  }

  Future<dynamic> register(authCredentials) async {
    print('REPO: intentando registro con $authCredentials');

    var registerResult = await remoteRepo.register(authCredentials);
    // Si el resultado es true, guarda credenciales en LocalRepository
    if (registerResult['status'] == true) {
      var storeResult = await localRepo.saveUser(registerResult['user']);
    } else {
      var storeResult = await localRepo.removeUser();
    }

    return registerResult;
  }
}
