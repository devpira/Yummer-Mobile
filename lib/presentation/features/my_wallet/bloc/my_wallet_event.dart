part of 'my_wallet_bloc.dart';

abstract class MyWalletEvent extends Equatable {
  const MyWalletEvent();

  @override
  List<Object> get props => [];
}

class MyWalletEventAddCardMethod extends MyWalletEvent {
  final CardPaymentMethodModel? cardPaymentMethodModel;

  const MyWalletEventAddCardMethod({
    required this.cardPaymentMethodModel,
  });
}

class MyWalletEventChangeDefaultMethod extends MyWalletEvent {
  final CardPaymentMethodModel cardPaymentMethodModel;

  const MyWalletEventChangeDefaultMethod({
    required this.cardPaymentMethodModel,
  });
}

class MyWalletEventRemoveCardMethod extends MyWalletEvent {
  final CardPaymentMethodModel cardPaymentMethodModel;
  final String? posCustomerId;

  const MyWalletEventRemoveCardMethod({
    required this.cardPaymentMethodModel,
    required this.posCustomerId,
  });
}

class MyWalletEventLoadPaymentMethods extends MyWalletEvent {
  const MyWalletEventLoadPaymentMethods();
}