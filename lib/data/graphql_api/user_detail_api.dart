import 'package:injectable/injectable.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/data/core/graphql/graphql.dart';

@lazySingleton
class UserDetailApi extends AbstractGraphQL {
  UserDetailApi({
    required AppValues appValues,
  }) : super.instance(appValues: appValues);

  Future<bool> createUserDetail(
    String phoneNumber,
    String name,
    String email,
    String displayName,
  ) async {
    final Map<String, dynamic> result = await executeMutation(
      mutation: """
                mutation(
                    \$phoneNumber: String!,
                    \$name: String, 
                    \$email: String!, 
                    \$displayName: String!,
          ){
            createUser(phoneNumber: \$phoneNumber, name: \$name, email: \$email, displayName: \$displayName){
              status
              insertedId
            }
          }
         """,
      variables: {
        'phoneNumber': phoneNumber,
        'name': name,
        'email': email,
        'displayName': displayName,
      },
    ) as Map<String, dynamic>;

    if (result['createUser']['insertedId'].isEmpty == true) {
      throw const GraphQLException(
        errorMessage: "Failed to create user. Please try again.",
      );
    }

    return true;
  }

    Future<bool> updateUserDetail({
    required String id,
    required String name,
    required String email,
    String? profileImageUrl,
    String? bio,
  }) async {
    final Map<String, dynamic> result = await executeMutation(
      mutation: """
          mutation(
                \$_id: String!,
                \$name: String!,
                \$email: String!, 
                \$profileImageUrl: String!, 
                 \$bio: String!, 
          ){
            updateUser(
              _id: \$_id,
              name: \$name,
                email: \$email, 
                profileImageUrl: \$profileImageUrl
                bio: \$bio
                ){
              status
            }
          }
         """,
      variables: {
        '_id': id,
        'name': name,
        'email': email,
        'profileImageUrl': profileImageUrl?? "",
        'bio': bio?? "",
      },
    ) as Map<String, dynamic>;

      if (result['updateUser'] == null ||
        result['updateUser']['status'] == null ||
        !(result['updateUser']['status'] as bool)) {
      throw const GraphQLException(
        errorMessage:
            "Failed to update your user profile. Please try again.",
      );
    }

    return true;
  }

  Future<bool> doesDisplayNameExist(
    String displayName,
  ) async {
    final Map<String, dynamic> result = await executeMutation(
      mutation: """
                mutation(
                \$displayName: String!,
          ){
            doesDisplayNameExist( displayName: \$displayName){
              status
            }
          }
         """,
      variables: {
        'displayName': displayName,
      },
    ) as Map<String, dynamic>;

    if (result['doesDisplayNameExist'] == null ||
        result['doesDisplayNameExist']['status'] == null ||
        !(result['doesDisplayNameExist']['status'] as bool)) {
      return false;
    }

    return true;
  }

  Future<Map<String, dynamic>?> getUserDetail() async {
    final Map<String, dynamic> result = await executeQuery(query: """
          query GetUser() {
            userDetail {
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
            }
          }
      """, variables: {}) as Map<String, dynamic>;

    if (result['userDetail']['_id'].isEmpty == true) {
      return null;
    }

    return result['userDetail'] as Map<String, dynamic>?;
  }

  Future<List<Object?>> searchUserByDisplayName({
    required String searchTerm,
  }) async {
    final Map<String, dynamic> result = await executeQuery(
      query: """
          query searchUserByDisplayName(\$searchTerm: String!) {
            searchUserByDisplayName(searchTerm: \$searchTerm) {
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
        "searchTerm": searchTerm,
      },
    ) as Map<String, dynamic>;

    if (result['searchUserByDisplayName'] == null) {
      throw const GraphQLException(
        errorMessage: "Failed to search for user. Please try again.",
      );
    }

    return result['searchUserByDisplayName'] as List<Object?>;
  }
}
