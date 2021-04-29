import 'package:injectable/injectable.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/data/core/graphql/graphql.dart';

@lazySingleton
class OrderSessoionApi extends AbstractGraphQL {
  OrderSessoionApi({
    required AppValues appValues,
  }) : super.instance(appValues: appValues);

  Future<Map<String, dynamic>?> createOrderSession({
    required String? restaurantId,
    required String? restaurantPosAccountId,
    required String? paymentMethodId,
    required List<String?> productIds,
    required int totalCostUnitAmount,
  }) async {
    print("Start createOrderSession2");
    final Map<String, dynamic> result = await executeMutation(
      mutation: """
          mutation(
            \$restaurantId: String!, 
            \$restaurantPosAccountId: String!, 
            \$paymentMethodId: String!, 
            \$productIds: [String]!, 
            \$totalCostUnitAmount: Int!, 
            ){
            createOrderSession(
              restaurantId: \$restaurantId, 
              restaurantPosAccountId: \$restaurantPosAccountId, 
              paymentMethodId: \$paymentMethodId, 
              productIds: \$productIds, 
              totalCostUnitAmount: \$totalCostUnitAmount
              ){
                success
                error
                orderSession {
                    _id
                    restaurantId
                    paymentHoldChargeId
                    tableId
                    invoiceId
                    totalCostUnitAmount
                    orderStatus
                    cart {
                      product {
                          _id
                          name
                          description
                          imageUrls
                          priceUnitAmount
                          currencyCode
                      }
                      status
                    }
                }
            }
          }
         """,
      variables: {
        'restaurantId': restaurantId,
        'restaurantPosAccountId': restaurantPosAccountId,
        'paymentMethodId': paymentMethodId,
        'productIds': productIds,
        'totalCostUnitAmount': totalCostUnitAmount,
      },
    ) as Map<String, dynamic>;

    if (!result.containsKey('createOrderSession') == null || !(result['createOrderSession'] as Map<String, dynamic>).containsKey('success')) {
      throw const GraphQLException(
        errorMessage: "Failed to create order. Please try again.",
      );
    }

    return result['createOrderSession'] as Map<String, dynamic>?;
  }
}
