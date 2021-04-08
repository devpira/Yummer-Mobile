import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
      yield state.copyWith(showLoading: true);

      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        yield state.copyWith(showNoInternetError: true);
        return;
      }

      final cardPaymentMethods =
          await _myWalletRepository.getAllCardPaymentMethods();

      CardPaymentMethodModel defaultPaymentMethod;
      cardPaymentMethods.forEach((item) {
        if (item.isDefault) {
          defaultPaymentMethod = item;
        }
      });
      yield state.copyWith(
        isFetchInProgress: false,
        defaultPaymentMethod: defaultPaymentMethod,
        cardPaymentMethods: cardPaymentMethods,
      );
    } else if (event is MyWalletEventAddCardMethod) {
      print("ADDING A CARD");
      print(state.cardPaymentMethods.length);
      final copiedCardPaymentMethods = state.cardPaymentMethods.map((item) {
        return item.copyWith(isDefault: false);
      }).toList();
      copiedCardPaymentMethods.insert(0, event.cardPaymentMethodModel);

      yield state.copyWith(
        defaultPaymentMethod: event.cardPaymentMethodModel,
        cardPaymentMethods: copiedCardPaymentMethods,
      );
    } else if (event is MyWalletEventRemoveCardMethod) {
      yield state.copyWith(showLoading: true);

      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        yield state.copyWith(errorMessage: "No internet connection.");

        return;
      }

      print("REMOVING A CARD");
      final result = await _myWalletRepository.deletePaymentMethod(
          event.posCustomerId, event.cardPaymentMethodModel.id);

      if (!result) {
        yield state.copyWith(
            errorMessage:
                "Failed to delete payment method. Please try again later.");
        return;
      }

      final copiedCardPaymentMethods = state.cardPaymentMethods
          .where((item) => item.id != event.cardPaymentMethodModel.id)
          .toList();

      yield state.copyWith(
        defaultPaymentMethodCanBeNull: true,
        defaultPaymentMethod: state.defaultPaymentMethod != null &&
                state.defaultPaymentMethod.id == event.cardPaymentMethodModel.id
            ? null
            : state.defaultPaymentMethod,
        cardPaymentMethods: copiedCardPaymentMethods,
      );
    } else if (event is MyWalletEventChangeDefaultMethod) {
      yield state.copyWith(showLoading: true);

      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        yield state.copyWith(errorMessage: "No internet connection.");
        return;
      }

      final result = await _myWalletRepository
          .changeDefaultPaymentMethod(event.cardPaymentMethodModel.id);

      if (!result) {
        yield state.copyWith(
            errorMessage:
                "Failed to change default payment method. Please try again later.");
        return;
      }

    final copiedCardPaymentMethods = state.cardPaymentMethods.map((item) {
        if (item.id == event.cardPaymentMethodModel.id) {
          return item.copyWith(isDefault: true);
        }
        return item.copyWith(isDefault: false);
      }).toList();

      yield state.copyWith(
        defaultPaymentMethod: event.cardPaymentMethodModel,
        cardPaymentMethods: copiedCardPaymentMethods,
      );
    }
  }
}
