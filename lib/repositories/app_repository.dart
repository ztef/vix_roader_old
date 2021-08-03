import 'package:vix_m/repositories/remote_repository.dart';
import 'package:vix_m/repositories/local_repository.dart';

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

  Future<String> readLocalUser() async {
    await Future.delayed(Duration(seconds: 5));
    return '';
  }

  Future<dynamic> login(authCredentials) async {
    print('REPO: intentando login con $authCredentials');

    var loginResult = await remoteRepo.login(authCredentials);
    // Si el resultado es true, guarda credenciales en LocalRepository
    if (loginResult['status'] == true) {
    } else {}

    return loginResult;
  }
}
