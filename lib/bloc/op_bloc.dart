import 'package:bloc/bloc.dart';
import 'package:vix_roader/events/op_events.dart';
import 'package:vix_roader/states/op_states.dart';
import 'package:vix_roader/repositories/app_repository.dart';

// VIX: Visual Interaction Systems Corp. 2021
// Mobile Framework
// BLoC Business Logic Component

class OpBloc extends Bloc<OpEvent, OpState> {
  final AppRepository appRepo;

  // Registra el Repositorio central de la app y setea el estado Inicial
  OpBloc(this.appRepo) : super(IdleState());

  @override
  Stream<OpState> mapEventToState(OpEvent event) async* {
    if (event is StartingOp) {
      print('OP BLOC : Inicia Operación');
      // Leyendo estatus :
      var userStatus = await appRepo.readLocalUserStatus();
      if ((userStatus.get('onTravel') == '')) {
        print('OP BLOC: No hay Estatus. Creando Registro');
        var result = await appRepo.createLocalUserStatus();
        if (result) {
          yield IdleState();
        }
      } else
        yield IdleState();
    } else if (event is StartTrip) {
      yield TravelState(event.tripData);
    } else if (event is StopTrip) {
      yield IdleState();
    }
  }
}
