import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:yummer/data/data.dart';
import 'package:yummer/domain/my_wallet/models/card_payment_method_model.dart';

@lazySingleton
class MyWalletRepository {
  final MyWalletApi _myWalletApi;

  const MyWalletRepository({
    @required MyWalletApi myWalletApi,
  })  : assert(myWalletApi != null),
        _myWalletApi = myWalletApi;

  Future<List<CardPaymentMethodModel>> getAllCardPaymentMethods() async {
    try {
      final List<CardPaymentMethodModel> resultList = [];
      final result = await _myWalletApi.getAllCardPaymentMethods();
    
      for (final Object item in result) {
        resultList
            .add(CardPaymentMethodModel.fromMap(item as Map<String, dynamic>));
      }  
      print(resultList);
      return resultList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> attachPaymentMethod(String paymentMethodId) async {
    try {
      return await _myWalletApi.attachPaymentMethod(paymentMethodId);
    } catch (e) {
      print(e);
      return false;
    }
  }
}
