import 'package:injectable/injectable.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/data/core/graphql/graphql.dart';

@lazySingleton
class UserFollowApi extends AbstractGraphQL {
  UserFollowApi({
    required AppValues appValues,
  }) : super.instance(appValues: appValues);

  Future<bool> followUser(
    String followUid,
  ) async {
    final Map<String, dynamic> result = await executeMutation(
      mutation: """
          mutation(\$followUid: String!){
            followUser(followUid: \$followUid){
              status
            }
          }
         """,
      variables: {
        'followUid': followUid,
      },
    ) as Map<String, dynamic>;

    if (result['followUser'] == null ||
        result['followUser']['status'] == null ||
        !(result['followUser']['status'] as bool)) {
      throw const GraphQLException(
        errorMessage: "Failed to follow user. Please try again.",
      );
    }

    return true;
  }

  Future<bool> unFollowUser(
    String unFollowUid,
  ) async {
    final Map<String, dynamic> result = await executeMutation(
      mutation: """
          mutation(\$unFollowUid: String!){
            unFollowUser(unFollowUid: \$unFollowUid){
              status
            }
          }
         """,
      variables: {
        'unFollowUid': unFollowUid,
      },
    ) as Map<String, dynamic>;

    if (result['unFollowUser'] == null ||
        result['unFollowUser']['status'] == null ||
        !(result['unFollowUser']['status'] as bool)) {
      throw const GraphQLException(
        errorMessage: "Failed to follow user. Please try again.",
      );
    }

    return true;
  }

  Future<List<Object?>> getAllMyFollowers(String uid) async {
    final Map<String, dynamic> result = await executeQuery(
      query: """
          query allMyFollowers(\$uid: String!) {
            allMyFollowers(uid: \$uid) {
              _id
              uid
              phoneNumber
              name
              email
              posCustomerId
              displayName
              profileImageUrl
              bio
              followerCount
              followingCount
              following
            }
          }
      """,
      variables: {
        "uid": uid,
      },
    ) as Map<String, dynamic>;

    if (result['allMyFollowers'] == null) {
      throw const GraphQLException(
        errorMessage: "Failed to get all my followers. Please try again.",
      );
    }

    return result['allMyFollowers'] as List<Object?>;
  }

  Future<List<Object?>> getAllMyFollowings(String uid) async {
    final Map<String, dynamic> result = await executeQuery(
      query: """
          query allMyFollowings(\$uid: String!) {
            allMyFollowings(uid: \$uid) {
              _id
              uid
              phoneNumber
              name
              email
              posCustomerId
              displayName
              profileImageUrl
              bio
              followerCount
              followingCount
              following
            }
          }
      """,
      variables: {
        "uid": uid,
      },
    ) as Map<String, dynamic>;

    if (result['allMyFollowings'] == null) {
      throw const GraphQLException(
        errorMessage: "Failed to get all my followings. Please try again.",
      );
    }

    return result['allMyFollowings'] as List<Object?>;
  }

  Future<Map<String, dynamic>> getMyFollowCount() async {
    final Map<String, dynamic> result = await executeQuery(
      query: """
          query myFollowCount() {
            myFollowCount() {
              followerCount
              followingCount
            }
          }
      """,
      variables: {},
    ) as Map<String, dynamic>;

    if (result['myFollowCount'] == null) {
      throw const GraphQLException(
        errorMessage: "Failed to get all my following count. Please try again.",
      );
    }

    return result['myFollowCount'] as Map<String, dynamic>;
  }
}
