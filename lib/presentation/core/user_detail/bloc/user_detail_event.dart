part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class UserDetailLoadRequested extends UserDetailEvent {
  final UserModel user;
  const UserDetailLoadRequested({required this.user});

  @override
  List<Object> get props => [user];
}

class UserDetailEventUpdateUserDetailsState extends UserDetailEvent {
  final UserDetailModel userDetailModel;

  const UserDetailEventUpdateUserDetailsState({
    required this.userDetailModel,
  });
}

class UserDetailEventRefreshFollowCount extends UserDetailEvent {}

class UserFollowEventFollowUser extends UserDetailEvent {
  final String followerUid;

  const UserFollowEventFollowUser({
    required this.followerUid,
  });
}

class UserFollowEventUnFollowUser extends UserDetailEvent {
  final String unFollowerUid;

  const UserFollowEventUnFollowUser({
    required this.unFollowerUid,
  });
}

class UserDetailRemoveRequested extends UserDetailEvent {}
