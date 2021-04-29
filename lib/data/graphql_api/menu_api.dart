import 'package:injectable/injectable.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/data/core/graphql/graphql.dart';

@lazySingleton
class MenuApi extends AbstractGraphQL {
  MenuApi({
    required AppValues appValues,
  }) : super.instance(appValues: appValues);

  Future<Map<String, dynamic>?> getCurrentRestaurantMenyToDisplay(
      String restaurantId) async {
    final Map<String, dynamic> result = await executeQuery(
      query: """
          query GetCurrentRestaurantMenyToDisplay(\$restaurantId: String)  {
            currentRestaurantMenuToDisplay(restaurantId: \$restaurantId) {
              _id
              restaurantId
              name
              displayGroups {
                _id
                name
                products {
                      _id
                      posProductId
                      priceUnitAmount
                      currencyCode
                      name
                      description
                      imageUrls
                      modiferGroups {
                             _id
                              name
                              minSelection
                              maxSelection
                              modifiers {
                                     _id
                                    name
                                    priceUnitAmount
                              }
                      }
                }
              }
            }
          }
      """,
      variables: {
        'restaurantId': restaurantId,
      },
    ) as Map<String, dynamic>;

    if (result['currentRestaurantMenuToDisplay']['_id'].isEmpty == true) {
      return null;
    }

    return result['currentRestaurantMenuToDisplay'] as Map<String, dynamic>?;
  }
}
