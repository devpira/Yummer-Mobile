part of 'user_search_bloc.dart';

class UserSearchState extends Equatable {
  final List<UserDetailModel>? resultList;
  final UserSearchPageState? pageState;

  const UserSearchState({
    this.resultList,
    this.pageState,
  });

  @override
  List<Object?> get props => [resultList, pageState];

  UserSearchState copyWith({
    List<UserDetailModel>? resultList,
    UserSearchPageState? pageState,

  }) {
    return UserSearchState(
      resultList: resultList ?? this.resultList,
      pageState: pageState ?? this.pageState,
    );
  }
}

abstract class UserSearchPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserSearchPageStateInitial extends UserSearchPageState {}

class UserSearchPageStateError extends UserSearchPageState {
  final String? errorMessage;
  UserSearchPageStateError({
    this.errorMessage,
  });
}

class UserSearchPageStateNoInternet extends UserSearchPageState {}

class UserSearchPageStateLoading extends UserSearchPageState {}

class UserSearchPageStateResultsLoaded extends UserSearchPageState {}

class UserSearchPageStateNoResultsFound extends UserSearchPageState {}

class UserSearchPageStateKeepTyping extends UserSearchPageState {}
