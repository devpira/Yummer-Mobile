import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:yummer/domain/user/user_detail.dart';

part 'user_follow_event.dart';
part 'user_follow_state.dart';

@injectable
class UserFollowBloc extends Bloc<UserFollowEvent, UserFollowState> {
  final UserFollowRepository _userFollowRepository;

  UserFollowBloc({
    required UserFollowRepository userFollowRepository,
  })   : _userFollowRepository = userFollowRepository,
        super(const UserFollowState());

  @override
  Stream<UserFollowState> mapEventToState(
    UserFollowEvent event,
  ) async* {
    if (event is UserFollowEventLoadMyFollowers) {
      yield state.copyWith(isFollowersListLoading: true);

      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        yield state.copyWith(showNoInternetView: true);
        return;
      }

      final result =
          await _userFollowRepository.getAllMyFollowers(uid: event.uid);
      if (result == null) {
        yield state.copyWith(showErrorView: true);
        return;
      }

      yield state.copyWith(followersList: result);
    } else if (event is UserFollowEventLoadMyFollowing) {
      yield state.copyWith(isFollowingListLoading: true);

      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        yield state.copyWith(showNoInternetView: true);
        return;
      }

      final result =
          await _userFollowRepository.getAllMyFollowings(uid: event.uid);
      if (result == null) {
        yield state.copyWith(showErrorView: true);
        return;
      }

      yield state.copyWith(followingList: result);
    }
  }
}
