abstract class ProfileEvent {
  const ProfileEvent();
}

class View extends ProfileEvent {}

class Edit extends ProfileEvent {}

class Stage extends ProfileEvent {}

class Commit extends ProfileEvent {}

class Push extends ProfileEvent {}

class Pull extends ProfileEvent {}

class Sync extends ProfileEvent {}
