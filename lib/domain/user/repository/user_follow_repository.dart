import 'package:injectable/injectable.dart';
import 'package:yummer/data/graphql_api/user_follow_api.dart';
import 'package:yummer/domain/user/user_detail.dart';

@lazySingleton
class UserFollowRepository {
  final UserFollowApi _userFollowApi;

  const UserFollowRepository({
    required UserFollowApi userFollowApi,
  }) : _userFollowApi = userFollowApi;

  Future<bool> followUser(
    String followUid,
  ) async {
    try {
      return await _userFollowApi.followUser(followUid);
    } catch (e) {
      // await Sentry.captureException(
      //   e,
      //   stackTrace: stackTrace,
      // );
      return false;
    }
  }

  Future<bool> unFollowUser(
    String unFollowUid,
  ) async {
    try {
      return await _userFollowApi.unFollowUser(unFollowUid);
    } catch (e) {
      // await Sentry.captureException(
      //   e,
      //   stackTrace: stackTrace,
      // );
      return false;
    }
  }

  Future<List<UserDetailModel>?> getAllMyFollowers({
    required String uid,
  }) async {
    try {
      final List<UserDetailModel> list = [];
      final List<Object?> result = await _userFollowApi.getAllMyFollowers(uid);
      for (final Object? item in result) {
        list.add(UserDetailModel.fromMap(item as Map<String, dynamic>));
      }

      return list;
    } catch (e, stackTrace) {
      // await Sentry.captureException(
      //   e,
      //   stackTrace: stackTrace,
      // );
      print(e.toString());
      print(stackTrace.toString());
      return null;
    }
  }

  Future<List<UserDetailModel>?> getAllMyFollowings({
    required String uid,
  }) async {
    try {
      final List<UserDetailModel> list = [];
      final List<Object?> result = await _userFollowApi.getAllMyFollowings(uid);
      for (final Object? item in result) {
        list.add(UserDetailModel.fromMap(item as Map<String, dynamic>));
      }

      return list;
    } catch (e, stackTrace) {
      // await Sentry.captureException(
      //   e,
      //   stackTrace: stackTrace,
      // );
      print(e.toString());
      print(stackTrace.toString());
      return null;
    }
  }

  Future<UserDetailModel> refreshFollowCount({
    required UserDetailModel userDetailModel,
  }) async {
    try {
      final Map<String, dynamic> result =
          await _userFollowApi.getMyFollowCount();
      if (result["followerCount"] == null || result["followingCount"] == null) {
        throw Exception("Failed to get my follow count");
      }

      return userDetailModel.copyWith(
        followerCount: result["followerCount"] as int,
        followingCount: result["followingCount"] as int,
      );
    } catch (e, stackTrace) {
      // await Sentry.captureException(
      //   e,
      //   stackTrace: stackTrace,
      // );
      print(e.toString());
      print(stackTrace.toString());
      return userDetailModel;
    }
  }
}
