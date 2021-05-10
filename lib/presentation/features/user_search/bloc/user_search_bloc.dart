import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:yummer/domain/user/user_detail.dart';

part 'user_search_event.dart';
part 'user_search_state.dart';

@injectable
class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  final UserDetailRepository _userDetailRepository;
  UserSearchBloc({
    required UserDetailRepository userDetailRepository,
  })   : _userDetailRepository = userDetailRepository,
        super(UserSearchState(
          resultList: const [],
          pageState: UserSearchPageStateInitial(),
        ));

  @override
  Stream<UserSearchState> mapEventToState(
    UserSearchEvent event,
  ) async* {
    if (event is UserSearchEventSearche) {
      yield await searchUserByKeyWord(event.searchTerm);
    }
  }

  Future<UserSearchState> searchUserByKeyWord(String? keyWord) async {
    try {
      if (keyWord == null || keyWord.isEmpty) {
        return state
            .copyWith(pageState: UserSearchPageStateInitial(), resultList: []);
      }
      if (keyWord.length < 2) {
        return state.copyWith(
            pageState: UserSearchPageStateKeepTyping(), resultList: []);
      }

      emit(state.copyWith(
        pageState: UserSearchPageStateLoading(),
      ));

      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return state.copyWith(pageState: UserSearchPageStateNoInternet());
      }

      final result = await _userDetailRepository.searchUserByDisplayName(
          searchTerm: keyWord);

      if (result == null) {
        throw Exception();
      }

      if (result.isNotEmpty) {
        return state.copyWith(
            resultList: result, pageState: UserSearchPageStateResultsLoaded());
      } else {
        return state.copyWith(
            resultList: result, pageState: UserSearchPageStateNoResultsFound());
      }
    } catch (e) {
      print(e.toString());
      return state.copyWith(
          pageState: UserSearchPageStateError(
              errorMessage:
                  "Unexpected error occurred while trying to find user. Please try again"));
    }
  }
}
