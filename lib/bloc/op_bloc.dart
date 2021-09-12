import 'package:bloc/bloc.dart';
import 'package:vix_roader/domain/domain_objects.dart';
import 'package:vix_roader/events/op_events.dart';
import 'package:vix_roader/states/op_states.dart';
import 'package:vix_roader/repositories/app_repository.dart';

// VIX: Visual Interaction Systems Corp. 2021
// Mobile Framework
// BLoC Business Logic Component

class OpBloc extends Bloc<OpEvent, OpState> {
  final AppRepository appRepo;
  late TripStatus tripStatus;
  var tripData;
  var pauseReason;

  // Registra el Repositorio central de la app y setea el estado Inicial
  OpBloc(this.appRepo) : super(IdleState());

  @override
  Stream<OpState> mapEventToState(OpEvent event) async* {
    if (event is StartTrip) {
      this.tripData = event.tripData;
    }
    if (event is PauseTrip) {
      this.pauseReason = event.pauseReason;
    }

    switch (event.runtimeType) {
      case StartingOp:
        print('OP BLOC : Inicia Operación');
        // Leyendo estatus :
        tripStatus = await appRepo.readLocalTripStatus();

        if ((tripStatus.get('onTravel') == '')) {
          print('OP BLOC: No hay Estatus. Creando Registro');
          var result = await appRepo.createLocalTripStatus();
          if (result) {
            yield IdleState();
          }
        } else if (tripStatus.get('onTravel') == true) {
          yield TravelState(tripStatus);
        } else {
          yield IdleState();
        }
        break;

      case StartTrip:
        this.tripStatus.set('tripData', tripData);
        this.tripStatus.set('onTravel', true);
        this.tripStatus.set('available', false);
        this.tripStatus.set('moveStatus', 'paused');
        this.tripStatus.set('pauseReason', '');

        await appRepo.saveLocalTripStatus(this.tripStatus);

        yield TravelState(this.tripStatus);
        break;

      case StopTrip:
        yield IdleState();
        break;
      case PauseTrip:
        this.tripStatus.set('moveStatus', 'paused');
        this.tripStatus.set('pauseReason', this.pauseReason);

        await appRepo.saveLocalTripStatus(this.tripStatus);

        yield TravelState(this.tripStatus);
        break;
      case UnPauseTrip:
        this.tripStatus.set('moveStatus', 'route');
        this.tripStatus.set('pauseReason', '');

        await appRepo.saveLocalTripStatus(this.tripStatus);

        yield TravelState(this.tripStatus);
        break;
    }
  }
}
