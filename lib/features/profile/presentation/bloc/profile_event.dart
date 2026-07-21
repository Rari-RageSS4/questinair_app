import 'package:equatable/equatable.dart';
import 'package:questinair_app/features/profile/domain/entities/profile_user_entity.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

// get profile
class LoadProfileEvent extends ProfileEvent {
  final String uid;

  const LoadProfileEvent(this.uid);

  @override
  List<Object?> get props => [uid];
}





class EnsureProfileExistsEvent extends ProfileEvent {
  final String uid;
  final String email;

  const EnsureProfileExistsEvent({
    required this.uid,
    required this.email,
  });

  @override
  List<Object?> get props => [uid, email];
}





class CreateProfileEvent extends ProfileEvent {
  final ProfileUserEntity user;
  const CreateProfileEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateProfileEvent extends ProfileEvent {
  final ProfileUserEntity user;
  const UpdateProfileEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class DeleteProfileEvent extends ProfileEvent {
  final String uid;

  const DeleteProfileEvent(this.uid);

  @override
  List<Object?> get props => [uid];
}
