import 'package:injectable/injectable.dart';

import 'package:yummer/data/core/graphql/graphql.dart';
import 'package:yummer/data/data.dart';
import 'package:yummer/domain/user/user_detail.dart';

@lazySingleton
class UserDetailRepository {
  final UserDetailApi _userDetailApi;

  const UserDetailRepository({
    required UserDetailApi userDetailApi,
  }) : _userDetailApi = userDetailApi;

  Future<void> createUserDetail(
      {required UserDetailModel userDetailModel}) async {
    try {
      await _userDetailApi.createUserDetail(
        userDetailModel.phoneNumber!,
        userDetailModel.name!,
        userDetailModel.email!,
        userDetailModel.displayName!,
      );
    } on GraphQLException catch (e) {
      print(e.toString());
      throw UserDetailFailure(errorMessage: e.toString());
    } catch (e) {
      print(e.toString());
      throw const UserDetailFailure(
          errorMessage: "Failed to create user. Please try again");
    }
  }

  Future<bool> updateUserDetail({
    required String id,
    required String name,
    required String email,
    String? profileImageUrl,
    String? bio,
  }) async {
    try {
      return await _userDetailApi.updateUserDetail(
        id: id,
        name: name,
        email: email,
        profileImageUrl: profileImageUrl,
        bio: bio,
      );
    } on GraphQLException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> doesDisplayNameExist({
    required String displayName,
  }) async {
    try {
      return await _userDetailApi.doesDisplayNameExist(
        displayName,
      );
    } catch (e) {
      print(e.toString());
      throw const UserDetailFailure(
          errorMessage:
              "Unexpected error occurred while checking is display name exists. Please try again");
    }
  }

  Future<UserDetailModel?> getUserDetail() async {
    try {
      final result = await _userDetailApi.getUserDetail();
      if (result == null) {
        return null;
      }
      return UserDetailModel.fromMap(result);
    } on GraphQLException catch (e) {
      print(e.toString());
      throw UserDetailFailure(errorMessage: e.toString());
    } catch (e) {
      print(e.toString());
      throw const UserDetailFailure(
          errorMessage: "Failed to get user. Please try again");
    }
  }

  
 Future<List<UserDetailModel>?> searchUserByDisplayName({
    required String searchTerm,
  }) async {
    try {
      final List<UserDetailModel> list = [];
      final List<Object?> result =
          await _userDetailApi.searchUserByDisplayName(searchTerm: searchTerm);
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
}

class UserDetailFailure implements Exception {
  final String errorCode;
  final String errorMessage;
  const UserDetailFailure({this.errorCode = "", this.errorMessage = ""});

  @override
  String toString() {
    return errorMessage;
  }
}
