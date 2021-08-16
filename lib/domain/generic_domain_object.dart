import 'package:vix_roader/domain/domain_objects.dart';

class GenericDomainObject {
  String objectId;
  DateTime timestamp = DateTime.now();
  Map payLoad;

  GenericDomainObject({
    required this.objectId,
    required this.payLoad,
  });

  update(payload) {
    this.payLoad = payload;
    this.timestamp = DateTime.now();
  }

  GenericDomainObject updateField(key, value) {
    this.payLoad[key] = value; // Reemplaza campo
    return this;
  }

  get(field) {
    return payLoad[field];
  }

  void set(key, value) {
    payLoad[key] = value;
  }

  clear() {
    this.payLoad = {};
    this.timestamp = DateTime.now();
  }

  Map<String, dynamic> toJson() => {
        'objectId': objectId,
        'timestamp': timestamp.toIso8601String(),
        'payLoad': payLoad,
      };

  factory GenericDomainObject.fromJson(json) {
    var tipo = json['objectId'];
    var mapa = json['payLoad'];
    return GenericDomainObject(objectId: tipo, payLoad: mapa);
  }

  factory GenericDomainObject.fromType(json) {
    var tipo = json['objectId'];
    var mapa = json['payLoad'];

    if (tipo == 'user_credentials') return UserCredentials(tipo, mapa);
    throw "$tipo objeto no reconocido.";
  }
}
