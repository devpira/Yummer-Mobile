import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:yummer/domain/my_wallet/models/card_payment_method_model.dart';

class CreditCardItem extends StatelessWidget {
  final CardPaymentMethodModel cardPaymentMethodModel;

  const CreditCardItem({
    @required this.cardPaymentMethodModel,
  });

  @override
  Widget build(BuildContext context) {


    CardType cardType = CardType.other;

    if (cardPaymentMethodModel.brand == "visa") {
      cardType = CardType.visa;
    }

    if (cardPaymentMethodModel.brand == "mastercard") {
      cardType = CardType.masterCard;
    }

    if (cardPaymentMethodModel.brand == "amex") {
      cardType = CardType.americanExpress;
    }

    if (cardPaymentMethodModel.brand == "diners_club") {
      cardType = CardType.dinersClub;
    }

    if (cardPaymentMethodModel.brand == "discover") {
      // cardType = CardType.discover;
    }

    if (cardPaymentMethodModel.brand == "jcb") {
      cardType = CardType.jcb;
    }

    return CreditCard(
      cardNumber: "**** **** **** ${cardPaymentMethodModel.last4}",
      cardExpiry:
          "${cardPaymentMethodModel.expMonth}/${cardPaymentMethodModel.expYear.toString().substring(2, 4)}",
      bankName: "Card",
      cardType: cardType,
      frontBackground: CardBackgrounds.black,
      backBackground: CardBackgrounds.white,
      showShadow: true,

      cardHolderName: "-",
    );
  }
}
