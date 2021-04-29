import 'package:injectable/injectable.dart';

import 'package:yummer/data/core/graphql/graphql.dart';
import 'package:yummer/data/data.dart';
import 'package:yummer/domain/user_detail/user_detail.dart';

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
        userDetailModel.phoneNumber,
        userDetailModel.name,
        userDetailModel.email,
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
