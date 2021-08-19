import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProfileBloc {
  final _userName = BehaviorSubject<String>();
  final _userPhone = BehaviorSubject<String>();

  ProfileBloc() {
    this._userName.add('Esteban');
  }

  getUserName() {
    return 'Esteban';
  }

  //Get
  Stream<String> get userName => _userName.stream.transform(validateUserName);
  Stream<double> get userPhone =>
      _userPhone.stream.transform(validateUserPhone);
  Stream<bool> get userValid =>
      Rx.combineLatest2(userName, userPhone, (userName, userPhone) => true);

  //Set
  Function(String) get changeUserName => _userName.sink.add;
  Function(String) get changeUserPhone => _userPhone.sink.add;

  dispose() {
    _userName.close();
    _userPhone.close();
  }

  //Transformers
  final validateUserName = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
    if (userName.length < 4) {
      sink.addError('Nombre muy corto');
    } else {
      sink.add(userName);
    }
  });

  final validateUserPhone = StreamTransformer<String, double>.fromHandlers(
      handleData: (userPhone, sink) {
    try {
      sink.add(double.parse(userPhone));
    } catch (error) {}
  });

  submitProfile() {
    print(
        'Enviando Profile: Nombre: ${_userName.value} and Teléfono: ${_userPhone.value}');
  }
}
