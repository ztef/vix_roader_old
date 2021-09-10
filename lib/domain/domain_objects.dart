import 'package:vix_roader/domain/generic_domain_object.dart';

class UserCredentials extends GenericDomainObject {
  UserCredentials(objectId, payLoad)
      : super(objectId: objectId, payLoad: payLoad);
}

class UserData extends GenericDomainObject {
  UserData(objectId, payLoad) : super(objectId: objectId, payLoad: payLoad);
}

class UserStatus extends GenericDomainObject {
  UserStatus(objectId, payLoad) : super(objectId: objectId, payLoad: payLoad);
}
