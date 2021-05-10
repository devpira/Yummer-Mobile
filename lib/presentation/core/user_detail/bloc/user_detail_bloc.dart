import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:yummer/domain/user/user_detail.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

@injectable
class UserDetailBloc extends HydratedBloc<UserDetailEvent, UserDetailState> {
  final UserDetailRepository _userDetailRepository;
  final UserFollowRepository _userFollowRepository;

  UserDetailBloc({
    required UserDetailRepository userDetailRepository,
    required UserFollowRepository userFollowRepository,
  })   : _userDetailRepository = userDetailRepository,
        _userFollowRepository = userFollowRepository,
        super(UserDetailNotLoaded());

  @override
  Stream<UserDetailState> mapEventToState(
    UserDetailEvent event,
  ) async* {
    if (event is UserDetailLoadRequested) {
      // Check if user detail is loaded:
      print("CAMEHERE");
      if (state is UserDetailLoaded) {
        print("CAMEHERE2");
        final UserDetailLoaded stateData = state as UserDetailLoaded;
        print(stateData.user.email);
        if (stateData.user != UserModel.empty &&
            stateData.userDetails.id != null) {
          yield UserDetailLoaded(
            user: stateData.user,
            userDetails: stateData.userDetails,
          );
          add(UserDetailEventRefreshFollowCount());
          return;
        }
      }
      print("CAMEHERE3");
      final connectivity = Connectivity();
      final ConnectivityResult result = await connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        yield UserDetailLoadLostInternet(user: event.user);
        return;
      }
      yield UserDetailLoading();
      yield await _mapUserDetailLoadRequestedToState(event);
      add(UserDetailEventRefreshFollowCount());
    } else if (event is UserDetailEventUpdateUserDetailsState) {
      final UserDetailLoaded stateData = state as UserDetailLoaded;
      yield UserDetailLoaded(
          user: stateData.user, userDetails: event.userDetailModel);
    } else if (event is UserDetailRemoveRequested) {
      print("CAME HERE2");
      yield UserDetailNotLoaded();
    } else if (event is UserFollowEventFollowUser) {
      _userFollowRepository.followUser(event.followerUid);
      add(UserDetailEventRefreshFollowCount());
    } else if (event is UserFollowEventUnFollowUser) {
      _userFollowRepository.unFollowUser(event.unFollowerUid);
      add(UserDetailEventRefreshFollowCount());
    } else if (event is UserDetailEventRefreshFollowCount) {
      final connectivity = Connectivity();
      final ConnectivityResult result = await connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return;
      }
      final UserDetailLoaded stateData = state as UserDetailLoaded;
      final userDetailModel = await _userFollowRepository.refreshFollowCount(
          userDetailModel: stateData.userDetails);
      yield UserDetailLoaded(
        user: stateData.user,
        userDetails: userDetailModel,
        isRefresh: true,
      );
      print("came here refre");
    }
  }

  Future<UserDetailState> _mapUserDetailLoadRequestedToState(
    UserDetailLoadRequested event,
  ) async {
    try {
      print("LOADING USER DETAILS FROM SERVER - START");
      final userDetailModel = await _userDetailRepository.getUserDetail();
      if (userDetailModel == null) {
        return UserDetailNotCreated();
      }
      print("LOADING USER DETAILS FROM SERVER - FINISHED");
      return UserDetailLoaded(user: event.user, userDetails: userDetailModel);
    } catch (e) {
      print(e.toString());
      return UserDetailLoadFailed(errorMessage: e.toString(), user: event.user);
    }
  }

  @override
  UserDetailState? fromJson(Map<String, dynamic> json) {
    print("FROM JSON");
    print(json);
    try {
      return UserDetailLoaded.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(UserDetailState state) {
    print("TO JSON");
    print(state);
    if (state is UserDetailLoaded) {
      return state.toMap();
    } else if (state is UserDetailNotLoaded) {
      return {"loaded": false};
    }
    return null;
  }
}
