import 'package:awesome_card/awesome_card.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:stripe_payment/stripe_payment.dart' as stripe;
import 'package:yummer/config/config.dart';
import 'package:yummer/domain/my_wallet/repository/my_wallet_repository.dart';
import 'package:yummer/presentation/features/my_wallet/my_wallet.dart';

part 'my_wallet_add_payment_state.dart';

@injectable
class MyWalletAddPaymentCubit extends Cubit<MyWalletAddPaymentState> {
  final AppValues _appValues;
  final MyWalletRepository _myWalletRepository;

  MyWalletAddPaymentCubit({
    @required AppValues appValues,
    @required MyWalletRepository myWalletRepository,
  })  : assert(appValues != null),
        assert(myWalletRepository != null),
        _appValues = appValues,
        _myWalletRepository = myWalletRepository,
        super(const MyWalletAddPaymentState());

  void cardNumberChanged(String value) {
    final number = CardNumberValueObject.dirty(value);
    CardType cardType = state.cardType;

    if (value != null && value.length == 1) {
      print(value[0]);
      if (value[0] == "5") {
        cardType = CardType.masterCard;
      }

      if (value[0] == "4") {
        cardType = CardType.visa;
      }

      if (value[0] == "3") {
        cardType = CardType.americanExpress;
      }
    }
    emit(
      state.copyWith(
        cardNumber: number,
        cardType: cardType,
        status: Formz.validate(
            [number, state.cardName, state.cardCvv, state.cardExpiryDate]),
      ),
    );
  }

  void cardExpiryDateChanged(String value) {
    final expirDate = CardExpiryDateValueObject.dirty(value);
    emit(
      state.copyWith(
        cardExpiryDate: expirDate,
        status: Formz.validate(
            [state.cardNumber, state.cardName, state.cardCvv, expirDate]),
      ),
    );
  }

  void cardCvvChanged(String value) {
    final cvv = CardCvvValueObject.dirty(value);
    emit(
      state.copyWith(
        cardCvv: cvv,
        showBackOfCard: true,
        status: Formz.validate(
            [state.cardNumber, state.cardName, cvv, state.cardExpiryDate]),
      ),
    );
  }

  void cardNameChanged(String value) {
    final name = CardNameValueObject.dirty(value);
    emit(
      state.copyWith(
        cardName: name,
        status: Formz.validate(
            [state.cardNumber, name, state.cardCvv, state.cardExpiryDate]),
      ),
    );
  }

  void toggleShowBackOfCard(bool value) {
    emit(
      state.copyWith(
        showBackOfCard: value,
      ),
    );
  }

  void startStripe() {
    stripe.StripePayment.setOptions(
      stripe.StripeOptions(
        publishableKey: _appValues.stripePublishableKey,
        merchantId: _appValues.stripeMerchantId,
        androidPayMode: _appValues.stripeAndroidPayMode,
      ),
    );
  }

  Future<void> createPaymentMethod() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      emit(
        state.copyWith(errorMessage: "No internet connection."),
      );
      return;
    }

    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
        // formSubmitted: true,
      ),
    );

    if (!state.status.isValidated ||
        state.cardExpiryDate.invalid ||
        state.cardCvv.invalid ||
        state.cardName.invalid ||
        state.cardNumber.invalid) {
      emit(state.copyWith(
        formSubmitted: true,
        status: Formz.validate([
          state.cardNumber,
          state.cardName,
          state.cardCvv,
          state.cardExpiryDate
        ]),
      ));
      return;
    }

    try {
      print(int.parse(
          state.cardExpiryDate.value[0] + state.cardExpiryDate.value[1]));
      final stripe.CreditCard paymentCard = stripe.CreditCard(
          number: state.cardNumber.value,
          expMonth: int.parse(
              state.cardExpiryDate.value[0] + state.cardExpiryDate.value[1]),
          expYear: int.parse(
              state.cardExpiryDate.value[2] + state.cardExpiryDate.value[3]),
          cvc: state.cardCvv.value,
          name: state.cardName.value);

      final stripe.BillingAddress address =
          stripe.BillingAddress(name: state.cardName.value);

      stripe.StripePayment.createPaymentMethod(
        stripe.PaymentMethodRequest(card: paymentCard, billingAddress: address),
      ).then((paymentMethod) async {
        print(paymentMethod.id);
        final result =
            await _myWalletRepository.attachPaymentMethod(paymentMethod.id);

        if (!result) {
          emit(
            state.copyWith(
                status: FormzStatus.submissionFailure,
                errorMessage:
                    "Failed to create payment method. Please try again."),
          );
        }
      }).catchError((error) {
        print(error);
        emit(
          state.copyWith(
              status: FormzStatus.submissionFailure,
              errorMessage: error != null && error.message != null
                  ? error.message as String
                  : "Failed to create payment method. Please try again."),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: e != null && e.toString().isNotEmpty
                ? e.toString()
                : "Failed to create payment method. Please try again."),
      );
    }
  }
}
