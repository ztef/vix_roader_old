import 'package:vix_roader/domain/domain_objects.dart';
import 'package:vix_roader/repositories/remote_auth_repository.dart';
import 'package:vix_roader/repositories/local_repository.dart';

class AuthRepository {
  late UserCredentials userCredentials;

  RemoteAuthRepository remoteRepo = new RemoteAuthRepository();
  LocalRepository localRepo = new LocalRepository();

  getUserCredentials() {
    return userCredentials;
  }

  setUserCredentials(UserCredentials newuserCredentials) {
    userCredentials = newuserCredentials;
  }

  setUserPhoto(userPhotoPath) {
    //userCredentials = userCredentials.updateField("imagePath", userPhotoPath);
  }

  Future<UserCredentials> readLocalUserCredentials() async {
    UserCredentials localUserCredentials =
        await localRepo.getLocalObject("user_credentials") as UserCredentials;
    this.userCredentials = localUserCredentials;
    return localUserCredentials;
  }

  Future<void> clearLocalUser() async {
    await localRepo.removeLocalObject("user_credentials");
    userCredentials.clear();
  }

  Future<dynamic> login(authCredentials) async {
    print('REPO: intentando login con $authCredentials');

    var loginResult = await remoteRepo.login(authCredentials);
    // Si el resultado es true, guarda credenciales en LocalRepository
    if (loginResult['status'] == true) {
      var opStatus = await localRepo.saveLocalObject(loginResult['user']);
      if (opStatus) {
        userCredentials = loginResult['user'];
      }
    } else {
      if (await localRepo.removeLocalObject("user_credentials")) {
        userCredentials.clear();
      }
    }

    return loginResult;
  }

  Future<dynamic> register(authCredentials) async {
    print('REPO: intentando registro con $authCredentials');

    var registerResult = await remoteRepo.register(authCredentials);
    // Si el resultado es true, guarda credenciales en LocalRepository
    if (registerResult['status'] == true) {
      var opStatus = await localRepo.saveLocalObject(registerResult['user']);
      if (opStatus) {
        userCredentials = registerResult['user'];
      }
    } else {
      if (await localRepo.removeLocalObject("user_credentials")) {
        userCredentials.clear();
      }
    }

    return registerResult;
  }
}
