import 'package:vix_roader/repositories/remote_repository.dart';
import 'package:vix_roader/repositories/local_repository.dart';
//import 'package:vix_roader/domain/generic_domain_object.dart';

class AppRepository {
  RemoteRepository remoteRepo = new RemoteRepository();
  LocalRepository localRepo = new LocalRepository();

/*
  Future<GenericDomainObject> readLocalUser() async {
    //domainObjects.user = await LocalRepository().getLocalObject("user");
    //return domainObjects.user;
  }
  */
}
