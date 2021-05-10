part of 'user_search_bloc.dart';

abstract class UserSearchEvent extends Equatable {
  const UserSearchEvent();

  @override
  List<Object?> get props => [];
}

class UserSearchEventSearche extends UserSearchEvent {
  final String? searchTerm;

  const UserSearchEventSearche({
    this.searchTerm,
  });

  @override
  List<Object?> get props => [searchTerm];
}
