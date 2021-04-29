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

class UserDetailRemoveRequested extends UserDetailEvent {}

