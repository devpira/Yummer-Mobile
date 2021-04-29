import 'package:injectable/injectable.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/data/core/graphql/graphql.dart';

@lazySingleton
class RestaurantApi extends AbstractGraphQL {
  RestaurantApi({
    required AppValues appValues,
  }) : super.instance(appValues: appValues);

  Future<List<Object>?> getAllBasicEnabledRestaurants() async {
    final Map<String, dynamic> result = await executeQuery(
      query: """
          query GetAllBasicEnabledRestaurants() {
            basicEnabledRestaurantInfos {
              _id
              name
              description
              imageUrl
            }
          }
      """,
      variables: {},
    ) as Map<String, dynamic>;

    if (result['basicEnabledRestaurantInfos'] == null) {
      throw const GraphQLException(
        errorMessage: "Failed to get all restaurants. Please try again.",
      );
    }

    return result['basicEnabledRestaurantInfos'] as List<Object>?;
  }

  Future<Map<String, dynamic>?> getFullRestaurantInfo(
      String restaurantId) async {
    final Map<String, dynamic> result = await executeQuery(
      query: """
          query GetFullRestaurantInfo(\$id: String)  {
            fullRestaurantInfo(id: \$id) {
              _id
              name
              description
              imageUrl
              addressLine1
              addressLine2
              city
              stateProvince
              country
              zipPostalCode
              phoneNumber
              email
              website
              posAccountId
            }
          }
      """,
      variables: {
        'id': restaurantId,
      },
    ) as Map<String, dynamic>;

    if (result['fullRestaurantInfo']['_id'].isEmpty == true) {
      return null;
    }

    return result['fullRestaurantInfo'] as Map<String, dynamic>?;
  }
}
