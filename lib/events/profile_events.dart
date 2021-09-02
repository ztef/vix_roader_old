abstract class ProfileEvent {
  const ProfileEvent();
}

class View extends ProfileEvent {}

class LoadCatalogs extends ProfileEvent {}

class Edit extends ProfileEvent {}

class LoadNewPhoto extends ProfileEvent {}

class AttemptToUpdate extends ProfileEvent {
  final profileData;
  const AttemptToUpdate(this.profileData) : super();
}

class Stage extends ProfileEvent {}

class Commit extends ProfileEvent {}

class Push extends ProfileEvent {}

class Pull extends ProfileEvent {}

class Sync extends ProfileEvent {}
