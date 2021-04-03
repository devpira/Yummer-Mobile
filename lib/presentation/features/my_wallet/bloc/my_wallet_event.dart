part of 'my_wallet_bloc.dart';

abstract class MyWalletEvent extends Equatable {
  const MyWalletEvent();

  @override
  List<Object> get props => [];
}

class MyWalletEventAddCardMethod extends MyWalletEvent {
  final CardPaymentMethodModel cardPaymentMethodModel;

  const MyWalletEventAddCardMethod({
    @required this.cardPaymentMethodModel,
  });
}

class MyWalletEventLoadPaymentMethods extends MyWalletEvent {
  const MyWalletEventLoadPaymentMethods();
}