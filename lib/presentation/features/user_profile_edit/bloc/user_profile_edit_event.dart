part of 'user_profile_edit_bloc.dart';

abstract class UserProfileEditEvent extends Equatable {
  const UserProfileEditEvent();

  @override
  List<Object> get props => [];
}

class UserProfileEditEventInitialize extends UserProfileEditEvent {
  final UserModel user;
  final UserDetailModel userDetails;
  
  const UserProfileEditEventInitialize({
    required this.user,
    required this.userDetails,
  });

  @override
  List<Object> get props => [userDetails];
}

class UserProfileEditEventNewImagePicked extends UserProfileEditEvent {
  final File pickedImageFile;

  const UserProfileEditEventNewImagePicked({required this.pickedImageFile});

  @override
  List<Object> get props => [pickedImageFile];
}

class UserProfileEditEventSavedClicked extends UserProfileEditEvent {}
