import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:yummer/domain/my_wallet/models/card_payment_method_model.dart';
import 'package:yummer/domain/my_wallet/repository/my_wallet_repository.dart';

part 'my_wallet_event.dart';
part 'my_wallet_state.dart';

@injectable
class MyWalletBloc extends Bloc<MyWalletEvent, MyWalletState> {
  final MyWalletRepository _myWalletRepository;

  MyWalletBloc({
    @required MyWalletRepository myWalletRepository,
  })  : assert(myWalletRepository != null),
        _myWalletRepository = myWalletRepository,
        super(const MyWalletState());

  @override
  Stream<MyWalletState> mapEventToState(
    MyWalletEvent event,
  ) async* {
    if (event is MyWalletEventLoadPaymentMethods) {
      final cardPaymentMethods = await _myWalletRepository.getAllCardPaymentMethods();
      yield state.copyWith(
        isFetchInProgress: false,
        cardPaymentMethods: cardPaymentMethods,
      );
    } else if (event is MyWalletEventAddCardMethod) {
      final cardPaymentMethods = state.cardPaymentMethods;
      cardPaymentMethods.add(event.cardPaymentMethodModel);
      yield state.copyWith(
        cardPaymentMethods: cardPaymentMethods,
      );
    }
  }
}
