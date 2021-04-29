import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:yummer/domain/user_detail/user_detail.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

@injectable
class UserDetailBloc extends HydratedBloc<UserDetailEvent, UserDetailState> {
  final UserDetailRepository _userDetailRepository;

  UserDetailBloc({
    required UserDetailRepository userDetailRepository,
  })  : assert(userDetailRepository != null),
        _userDetailRepository = userDetailRepository,
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
        if (stateData.user != null && stateData.userDetails != null) {
          yield state;
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
    } else if (event is UserDetailRemoveRequested) {
             print("CAME HERE2");
      yield UserDetailNotLoaded();
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
