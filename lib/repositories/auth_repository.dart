import 'package:vix_roader/repositories/remote_repository.dart';
import 'package:vix_roader/repositories/local_repository.dart';
import 'package:vix_roader/domain/user.dart';

class AuthRepository {
  late User user;

  RemoteRepository remoteRepo = new RemoteRepository();
  LocalRepository localRepo = new LocalRepository();

  getUser() {
    return user;
  }

  setUser(User newuser) {
    user = newuser;
  }

  Future<User> readLocalUser() async {
    User localUser = await localRepo.getUser();
    this.user = localUser;
    return localUser;
  }

  Future<void> clearLocalUser() async {
    await localRepo.removeUser();
    user.clear();
  }

  Future<dynamic> login(authCredentials) async {
    print('REPO: intentando login con $authCredentials');

    var loginResult = await remoteRepo.login(authCredentials);
    // Si el resultado es true, guarda credenciales en LocalRepository
    if (loginResult['status'] == true) {
      user = await localRepo.saveUser(loginResult['user']);
    } else {
      if (await localRepo.removeUser()) {
        user.clear();
      }
    }

    return loginResult;
  }

  Future<dynamic> register(authCredentials) async {
    print('REPO: intentando registro con $authCredentials');

    var registerResult = await remoteRepo.register(authCredentials);
    // Si el resultado es true, guarda credenciales en LocalRepository
    if (registerResult['status'] == true) {
      user = await localRepo.saveUser(registerResult['user']);
    } else {
      if (await localRepo.removeUser()) {
        user.clear();
      }
    }

    return registerResult;
  }
}
