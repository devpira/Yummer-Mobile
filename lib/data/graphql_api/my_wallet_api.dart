import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/data/core/graphql/graphql.dart';

@lazySingleton
class MyWalletApi extends AbstractGraphQL {
  MyWalletApi({
    @required AppValues appValues,
  }) : super.instance(appValues: appValues);

  Future<bool> attachPaymentMethod(
    String paymentMethodId,
  ) async {
    final Map<String, dynamic> result = await executeMutation(
      mutation: """
          mutation{
            attachPaymentMethod(paymentMethodId: "$paymentMethodId"){
              status
            }
          }
         """,
    ) as Map<String, dynamic>;

    if (result['attachPaymentMethod']['status'] == false) {
      throw const GraphQLException(
        errorMessage: "Failed to attach payment. Please try again.",
      );
    }

    return result['attachPaymentMethod']['status'] as bool;
  }

   Future<List<Object>> getAllCardPaymentMethods() async {
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
            }
          }
      """,
    ) as Map<String, dynamic>;

    if (result['cardPaymentMethods'] == null) {
      throw const GraphQLException(
        errorMessage: "Failed to get all card payment methods. Please try again.",
      );
    }

    return result['cardPaymentMethods'] as List<Object>;
  }
}
