import 'package:injectable/injectable.dart';
import 'package:yummer/data/data.dart';
import 'package:yummer/domain/order_session/order_session.dart';

@lazySingleton
class OrderSessionRepository {
  final OrderSessoionApi _orderSessoionApi;

  const OrderSessionRepository({
    required OrderSessoionApi orderSessoionApi,
  })  : assert(orderSessoionApi != null),
        _orderSessoionApi = orderSessoionApi;

  Future<OrderSessionModel?> createOrderSession({
    required String? restaurantId,
    required String? restaurantPosAccountId,
    required String? paymentMethodId,
    required List<String?> productIds,
    required int totalCostUnitAmount,
  }) async {
    try {
    
      final Map<String, dynamic> result =
          await (_orderSessoionApi.createOrderSession(
        restaurantId: restaurantId,
        restaurantPosAccountId: restaurantPosAccountId,
        paymentMethodId: paymentMethodId,
        productIds: productIds,
        totalCostUnitAmount: totalCostUnitAmount,
      ) as FutureOr<Map<String, dynamic>>);

      if (!result.containsKey('success') || result['success'] == null) {
        print("CAME HERE");
        return null;
      }

      if (!(result['success'] as bool)) {
        if (result['success']["error"].isEmpty == true) {
           print("CAME HERE1");
          return null;
        } else {
           print("CAME HERE5");
          throw OrderSessionException(
            errorMessage: result['success']["error"] as String?,
          );
        }
      }

      if (result["orderSession"] == null || result["orderSession"].isEmpty == true){
         print("CAME HERE2");
        return null;
      }
      print("finished here");
      print(result["orderSession"]);
      return OrderSessionModel.fromMap(result["orderSession"] as Map<String, dynamic>);
   } catch (e) {
     print(e);
     return null;
   }
  }
}
