import 'package:injectable/injectable.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/data/core/graphql/graphql.dart';

@lazySingleton
class MyWalletApi extends AbstractGraphQL {
  MyWalletApi({
    required AppValues appValues,
  }) : super.instance(appValues: appValues);

  Future<Map<String, dynamic>?> attachPaymentMethod(
    String paymentMethodId,
  ) async {
    const bool isDefault = true;

    final Map<String, dynamic> result = await executeMutation(mutation: """
          mutation(\$paymentMethodId: String!, \$isDefault:Boolean){
            attachPaymentMethod(paymentMethodId: \$paymentMethodId, isDefault: \$isDefault){
              id
              brand
              last4
              expMonth
              expYear
              isExpired
              isDefault
            }
          }
         """, variables: {
      "paymentMethodId": paymentMethodId,
      "isDefault": isDefault,
    }) as Map<String, dynamic>;

    if (result['attachPaymentMethod']['id'].isEmpty == true) {
      throw const GraphQLException(
        errorMessage: "Failed to attach payment. Please try again.",
      );
    }

    return result['attachPaymentMethod'] as Map<String, dynamic>?;
  }

  Future<bool?> deletePaymentMethod(
    String? posCustomerId,
    String? paymentMethodId,
  ) async {
    final Map<String, dynamic> result = await executeMutation(
      mutation: """
          mutation(\$posCustomerId:String!, \$paymentMethodId: String){
            deletePaymentMethod(posCustomerId: \$posCustomerId,paymentMethodId: \$paymentMethodId){
              status
            }
          }
         """,
      variables: {
        "posCustomerId": posCustomerId,
        "paymentMethodId": paymentMethodId,
      },
    ) as Map<String, dynamic>;

    if (result['deletePaymentMethod']['status'] == false) {
      throw const GraphQLException(
        errorMessage: "Failed to attach payment. Please try again.",
      );
    }

    return result['deletePaymentMethod']['status'] as bool?;
  }

  Future<bool?> changeDefaultPaymentMethod(String? paymentMethodId) async {
    final Map<String, dynamic> result = await executeMutation(
      mutation: """
          mutation(\$paymentMethodId: String!){
            changeDefaultPaymentMethod(paymentMethodId: \$paymentMethodId){
              status
            }
          }
         """,
      variables: {
        "paymentMethodId": paymentMethodId,
      },
    ) as Map<String, dynamic>;

    if (result['changeDefaultPaymentMethod']['status'] == false) {
      throw const GraphQLException(
        errorMessage: "Failed to attach payment. Please try again.",
      );
    }

    return result['changeDefaultPaymentMethod']['status'] as bool?;
  }

  Future<List<Object?>> getAllCardPaymentMethods() async {
    final Map<String, dynamic> result = await executeQuery(
      query: """
          query cardPaymentMethods() {
            cardPaymentMethods {
              id
              brand
              last4
              expMonth
              expYear
              isExpired
              isDefault
            }
          }
      """,
      variables: {}
    ) as Map<String, dynamic>;

    if (result['cardPaymentMethods'] == null) {
      throw const GraphQLException(
        errorMessage:
            "Failed to get all card payment methods. Please try again.",
      );
    }

    return result['cardPaymentMethods'] as List<Object?>;
  }
}
