class ProfileState {
  late final String? user;
}

class ViewState extends ProfileState {}

class NoConectionState extends ProfileState {}

class LoadingCatalogsState extends ProfileState {}

class EditState extends ProfileState {}

class EditCompleted extends ProfileState {}

class AttemptingToUpdate extends ProfileState {}

class NewPhoto extends ProfileState {}

class Updated extends ProfileState {}

class UpdateError extends ProfileState {}

class StageState extends ProfileState {}
