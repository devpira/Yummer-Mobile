import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/data/core/graphql/graphql.dart';


@lazySingleton
class UserDetailApi extends AbstractGraphQL {
  UserDetailApi({
    @required AppValues appValues,
  }) : super.instance(appValues: appValues);

  Future<bool> createUserDetail(
    String phoneNumber,
    String name,
    String email,
  ) async {
    final Map<String, dynamic> result = await executeMutation(
      mutation: """
          mutation{
            createUser(phoneNumber: "$phoneNumber", name: "$name", email: "$email"){
              status
              insertedId
            }
          }
         """,
    ) as Map<String, dynamic>;

    if (result['createUser']['insertedId'].isEmpty == true) {
      throw const GraphQLException(
        errorMessage: "Failed to create user. Please try again.",
      );
    }

    return true;
  }

  Future<Map<String, dynamic>> getUserDetail() async {
    final Map<String, dynamic> result = await executeQuery(
      query: """
          query GetUser() {
            userDetail {
              _id
              phoneNumber
              name
              email
            }
          }
      """,
    ) as Map<String, dynamic>;

    if (result['userDetail']['_id'].isEmpty == true) {
      return null;
    }

    return result['userDetail'] as Map<String, dynamic>;
  }
}
