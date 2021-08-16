import 'package:vix_roader/repositories/remote_auth_repository.dart';
import 'package:vix_roader/repositories/local_repository.dart';
import 'package:vix_roader/domain/generic_domain_object.dart';

class AuthRepository {
  late GenericDomainObject userCredentials;

  RemoteAuthRepository remoteRepo = new RemoteAuthRepository();
  LocalRepository localRepo = new LocalRepository();

  getUserCredentials() {
    return userCredentials;
  }

  setUserCredentials(GenericDomainObject newuserCredentials) {
    userCredentials = newuserCredentials;
  }

  setUserPhoto(userPhotoPath) {
    userCredentials = userCredentials.updateField("imagePath", userPhotoPath);
  }

  Future<GenericDomainObject> readLocalUserCredentials() async {
    GenericDomainObject localUserCredentials =
        await localRepo.getLocalObject("user_credentials");
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
      userCredentials = await localRepo.saveLocalObject(loginResult['user']);
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
      userCredentials = await localRepo.saveLocalObject(registerResult['user']);
    } else {
      if (await localRepo.removeLocalObject("user_credentials")) {
        userCredentials.clear();
      }
    }

    return registerResult;
  }
}
