import 'package:vix_roader/repositories/remote_repository.dart';
import 'package:vix_roader/repositories/local_repository.dart';
import 'package:vix_roader/domain/domain_objects.dart';

class AppRepository {
  late UserData userData;

  RemoteRepository remoteRepo = new RemoteRepository();
  LocalRepository localRepo = new LocalRepository();

  getUserData() {
    return userData;
  }

  Future<UserData> readLocalUserData() async {
    UserData localUserData =
        await localRepo.getLocalObject("user_data") as UserData;
    this.userData = localUserData;
    return localUserData;
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
    var result = await localRepo.saveLocalObject(userData);
    return result;
  }

  Future<dynamic> getUser(userCredentials) async {
    //print('REPO: intentando login con $authCredentials');

    var loginResult = await remoteRepo.login(userCredentials);
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
}
