part of 'user_follow_bloc.dart';

abstract class UserFollowEvent extends Equatable {
  const UserFollowEvent();

  @override
  List<Object> get props => [];
}

class UserFollowEventLoadMyFollowers extends UserFollowEvent {
  final String uid;
  const UserFollowEventLoadMyFollowers({
    required this.uid,
  });
}

class UserFollowEventLoadMyFollowing extends UserFollowEvent {
  final String uid;
  const UserFollowEventLoadMyFollowing({
    required this.uid,
  });
}
