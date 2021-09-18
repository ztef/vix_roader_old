import 'package:bloc/bloc.dart';
import 'package:vix_roader/bloc/time_logic.dart';
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
  var stopStatus;

  // Registra el Repositorio central de la app y setea el estado Inicial
  OpBloc(this.appRepo) : super(LoadingState());

  @override
  Stream<OpState> mapEventToState(OpEvent event) async* {
    print('OP BLOC : Inicia Operación');

    if (event is StartTrip) {
      this.tripData = event.tripData;
    }
    if (event is PauseTrip) {
      this.pauseReason = event.pauseReason;
    }
    if (event is StopTrip) {
      this.stopStatus = event.stopStatus;
    }

    switch (event.runtimeType) {
      case StartingOp:

        // Leyendo estatus :
        tripStatus = await appRepo.readLocalTripStatus();

        await appRepo.readLocalTripLogDB();
        await appRepo.readLocalTripHistoryDB();

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
        var tripId = this.tripStatus.getNumber('tripCounter') + 1;
        this.tripStatus.set('tripCounter', tripId);
        this.tripStatus.set('tripId', tripId);

        await appRepo.saveLocalTripStatus(this.tripStatus);
        await appRepo.tripLog(
            {'tripId': tripId, 'action': 'StartTrip', 'tripData': tripData});

        yield TravelState(this.tripStatus);
        break;

      case StopTrip:
        this.tripStatus.set('onTravel', false);
        this.tripStatus.set('available', false);
        this.tripStatus.set('moveStatus', 'paused');
        this.tripStatus.set('pauseReason', '');
        await appRepo.saveLocalTripStatus(this.tripStatus);

        var tripId = this.tripStatus.getNumber('tripId');
        await appRepo.tripLog({
          'tripId': tripId,
          'action': 'StopTrip',
          'stopReason': this.stopStatus,
        });

        var times = getAcumulatedDriveTime(appRepo.getTripLog());
        var dates = getTripDates(this.tripStatus);
        this.tripData = this.tripStatus.get('tripData');
        await appRepo.addTripToHistory({
          'tripId': tripId,
          'stopReason': this.stopStatus,
          'tripDates': dates,
          'tripTimes': times,
          'tripData': this.tripData,
        });

        yield IdleState();
        break;
      case PauseTrip:
        this.tripStatus.set('moveStatus', 'paused');
        this.tripStatus.set('pauseReason', this.pauseReason);

        var tripId = this.tripStatus.getNumber('tripId');
        await appRepo.saveLocalTripStatus(this.tripStatus);
        await appRepo.tripLog({
          'tripId': tripId,
          'action': 'PauseTrip',
          'pauseReason': this.pauseReason
        });

        yield TravelState(this.tripStatus);
        break;
      case UnPauseTrip:
        this.tripStatus.set('moveStatus', 'route');
        this.tripStatus.set('pauseReason', '');

        var tripId = this.tripStatus.getNumber('tripId');
        await appRepo.saveLocalTripStatus(this.tripStatus);
        await appRepo.tripLog({'tripId': tripId, 'action': 'UnPauseTrip'});

        yield TravelState(this.tripStatus);
        break;
      default:
    }
  }
}
