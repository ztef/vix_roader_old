import 'package:bloc/bloc.dart';
import 'package:vix_roader/events/profile_events.dart';
import 'package:vix_roader/states/profile_states.dart';
import 'package:vix_roader/repositories/app_repository.dart';

// VIX: Visual Interaction Systems Corp. 2021
// Mobile Framework
// BLoC Business Logic Component

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppRepository appRepo;
  Map<String, dynamic> initialValues = {};

  // Registra el Repositorio central de la forma y setea el estado Inicial
  ProfileBloc(this.appRepo) : super(LoadingCatalogsState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is View) {
      yield ViewState();
    } else {
      if (event is LoadCatalogs) {
        yield LoadingCatalogsState();
        if (await appRepo.getCatalogs()) {
          yield EditState();
        } else {
          yield NoConectionState();
        }
      } else if (event is Edit) {
        yield EditState();
      } else {
        if (event is AttemptToUpdate) {
          yield AttemptingToUpdate();
          print('PROFILE BLOC : ');
          print(event.profileData);

          var result = await appRepo.updateUserData(event.profileData);
          if (result) {
            yield EditCompleted();
            print('PROFILE Enviando a backend');
            yield ViewState();
          } else {
            yield UpdateError();
          }
        }
      }
    }
  }

  getInitialValues() {
    initialValues = appRepo.getUserDataObject().getRecord();
    return initialValues;
  }
}
