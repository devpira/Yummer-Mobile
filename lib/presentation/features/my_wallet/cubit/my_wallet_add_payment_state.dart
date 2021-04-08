part of 'my_wallet_add_payment_cubit.dart';

class MyWalletAddPaymentState extends Equatable {
  final CardNumberValueObject cardNumber;
  final CardExpiryDateValueObject cardExpiryDate;
  final CardCvvValueObject cardCvv;
  final CardNameValueObject cardName;
  final CardType cardType;

  final bool showBackOfCard;

  final FormzStatus status;
  final String errorMessage;
  final bool formSubmitted;

  final CardPaymentMethodModel addedCardPaymentMethod;

  const MyWalletAddPaymentState({
    this.cardNumber = const CardNumberValueObject.dirty(),
    this.cardExpiryDate = const CardExpiryDateValueObject.dirty(),
    this.cardCvv = const CardCvvValueObject.dirty(),
    this.cardName = const CardNameValueObject.dirty(),
    this.cardType = CardType.other,
    this.showBackOfCard = false,
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.formSubmitted = false,
    this.addedCardPaymentMethod,
  });

  @override
  List<Object> get props {
    return [
      cardNumber,
      cardExpiryDate,
      cardCvv,
      cardName,
      cardType,
      showBackOfCard,
      status,
      errorMessage,
      formSubmitted,
      addedCardPaymentMethod,
    ];
  }

  MyWalletAddPaymentState copyWith({
    CardNumberValueObject cardNumber,
    CardExpiryDateValueObject cardExpiryDate,
    CardCvvValueObject cardCvv,
    CardNameValueObject cardName,
    CardType cardType,
    bool showBackOfCard,
    FormzStatus status,
    String errorMessage,
    bool formSubmitted,
    CardPaymentMethodModel addedCardPaymentMethod,
  }) {
    return MyWalletAddPaymentState(
      cardNumber: cardNumber ?? this.cardNumber,
      cardExpiryDate: cardExpiryDate ?? this.cardExpiryDate,
      cardCvv: cardCvv ?? this.cardCvv,
      cardName: cardName ?? this.cardName,
      cardType: cardType ?? this.cardType,
      showBackOfCard: showBackOfCard ?? false,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      formSubmitted: formSubmitted ?? this.formSubmitted,
      addedCardPaymentMethod: addedCardPaymentMethod?? this.addedCardPaymentMethod
    );
  }
}
