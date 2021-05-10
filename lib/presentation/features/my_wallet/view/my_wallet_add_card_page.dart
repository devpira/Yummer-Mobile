import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/feature.dart';
import 'package:formz/formz.dart';

class MyWalletAddCardPage extends StatelessWidget {
  final MyWalletBloc myWalletBloc;
  const MyWalletAddCardPage({
    required this.myWalletBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: myWalletBloc,
        ),
        BlocProvider<MyWalletAddPaymentCubit>(
          create: (_) => getIt<MyWalletAddPaymentCubit>(),
        ),
      ],
      child: _MyWalletAddCardPage(),
    );
  }
}

class _MyWalletAddCardPage extends StatefulWidget {
  @override
  ___MyWalletAddCardPageeState createState() => ___MyWalletAddCardPageeState();
}

class ___MyWalletAddCardPageeState extends State<_MyWalletAddCardPage> {
  @override
  initState() {
    super.initState();
    context.read<MyWalletAddPaymentCubit>().startStripe();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

        title: Text(
          "Add Card",
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        // leading: Padding(
        //   padding: EdgeInsets.all(screenWidth * 0.012),
        //   child: const WhiteBackButton(shadow: 0),
        // ),
      ),
      body: BlocListener<MyWalletAddPaymentCubit, MyWalletAddPaymentState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                ),
              );
          } else if (state.status.isSubmissionSuccess) {
            context.read<MyWalletBloc>().add(
                  MyWalletEventAddCardMethod(
                      cardPaymentMethodModel: state.addedCardPaymentMethod),
                );
                Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              _CreditCardPreview(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    // TextFieldStyleOne(
                    //   screenWidth: screenWidth,
                    //   screenHeight: screenHeight,
                    //   keyboardType: TextInputType.number,
                    //   onChanged: () {},
                    //   labelText: "Card Number",
                    // ),
                    _CardNumberInput(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                      width: screenWidth,
                      child: Row(
                        children: [
                          Expanded(
                            child: _CardExpiryDateInput(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                            // TextFieldStyleOne(
                            //   screenWidth: screenWidth,
                            //   screenHeight: screenHeight,
                            //   keyboardType: TextInputType.datetime,
                            //   onChanged: () {},
                            //   labelText: "Expiry Date",
                            // ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Expanded(
                            child: _CardCvvInput(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                            // TextFieldStyleOne(
                            //   screenWidth: screenWidth,
                            //   screenHeight: screenHeight,
                            //   keyboardType: TextInputType.number,
                            //   onChanged: () {},
                            //   labelText: "CVV",
                            // ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    _CardNameInput(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                    // TextFieldStyleOne(
                    //   screenWidth: screenWidth,
                    //   screenHeight: screenHeight,
                    //   onChanged: () {},
                    //   labelText: "Card Holder Name",
                    // ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    _SaveButton()
                    // AccentRaisedButton(
                    //   onClick: () {},
                    //   text: "Save",
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreditCardPreview extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _CreditCardPreview({
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyWalletAddPaymentCubit, MyWalletAddPaymentState>(
      buildWhen: (previous, current) =>
          previous.cardNumber != current.cardNumber ||
          previous.cardExpiryDate != current.cardExpiryDate ||
          previous.cardCvv != current.cardCvv ||
          previous.cardName != current.cardName ||
          previous.cardType != current.cardType ||
          previous.showBackOfCard != current.showBackOfCard,
      builder: (context, state) {
        return CreditCard(
          cardNumber: state.cardNumber.value,
          cardExpiry: state.cardExpiryDate.value.length > 2
              ? "${state.cardExpiryDate.value.substring(0, 2)}/${state.cardExpiryDate.value.substring(2)}"
              : state.cardExpiryDate.value,
          cardHolderName: state.cardName.value.length > 19
              ? state.cardName.value
                  .replaceRange(20, state.cardName.value.length, '...')
              : state.cardName.value,
          cvv: state.cardCvv.value,

          bankName: "Card",
          cardType: state.cardType,
          showBackSide: state.showBackOfCard,
          frontBackground: CardBackgrounds.black,
          backBackground: CardBackgrounds.white,
          showShadow: true,

          // textExpDate: 'Exp. Date',
          // textName: 'Name',
          // textExpiry: 'MM/YY',
        );
      },
    );
  }
}

class _CardNumberInput extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _CardNumberInput({
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyWalletAddPaymentCubit, MyWalletAddPaymentState>(
      buildWhen: (previous, current) =>
          previous.cardNumber != current.cardNumber ||
          previous.formSubmitted != current.formSubmitted,
      builder: (context, state) {
        return TextFieldStyleOne(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          keyboardType: TextInputType.number,
          onChanged: (String number) =>
              context.read<MyWalletAddPaymentCubit>().cardNumberChanged(number),
          textInputAction: TextInputAction.next,
          maxLength: 16,
          labelText: 'Card Number',
          helperText: '',
          errorText: state.formSubmitted && state.cardNumber.invalid
              ? 'Required'
              : null,
        );
      },
    );
  }
}

class _CardExpiryDateInput extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _CardExpiryDateInput({
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyWalletAddPaymentCubit, MyWalletAddPaymentState>(
      buildWhen: (previous, current) =>
          previous.cardExpiryDate != current.cardExpiryDate ||
          previous.formSubmitted != current.formSubmitted,
      builder: (context, state) {
        return TextFieldStyleOne(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          keyboardType: TextInputType.number,
          onChanged: (String value) => context
              .read<MyWalletAddPaymentCubit>()
              .cardExpiryDateChanged(value),
          textInputAction: TextInputAction.next,
          labelText: 'Expiry Date',
          helperText: '',
          maxLength: 4,
          errorText: state.formSubmitted && state.cardExpiryDate.invalid
              ? 'Invalid Date'
              : null,
        );
      },
    );
  }
}

class _CardCvvInput extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _CardCvvInput({
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyWalletAddPaymentCubit, MyWalletAddPaymentState>(
      buildWhen: (previous, current) =>
          previous.cardCvv != current.cardCvv ||
          previous.formSubmitted != current.formSubmitted,
      builder: (context, state) {
        return TextFieldStyleOne(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          keyboardType: TextInputType.number,
          onChanged: (String value) =>
              context.read<MyWalletAddPaymentCubit>().cardCvvChanged(value),
          textInputAction: TextInputAction.next,
          labelText: 'CVV',
          helperText: '',
          maxLength: 3,
          errorText: state.formSubmitted && state.cardCvv.invalid
              ? 'Invalid CVV'
              : null,
        );
      },
    );
  }
}

class _CardNameInput extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _CardNameInput({
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyWalletAddPaymentCubit, MyWalletAddPaymentState>(
      buildWhen: (previous, current) =>
          previous.cardName != current.cardName ||
          previous.formSubmitted != current.formSubmitted,
      builder: (context, state) {
        return TextFieldStyleOne(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onChanged: (String value) =>
              context.read<MyWalletAddPaymentCubit>().cardNameChanged(value),
          textInputAction: TextInputAction.done,
          labelText: 'Card Holder Name',
          helperText: '',
          maxLength: 50,
          errorText:
              state.formSubmitted && state.cardName.invalid ? 'Required' : null,
        );
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyWalletAddPaymentCubit, MyWalletAddPaymentState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AccentRaisedButton(
          onClick: () =>
              context.read<MyWalletAddPaymentCubit>().createPaymentMethod(),
          text: "Save",
          showProgressBar: state.status.isSubmissionInProgress,
          elevation: 0,
          textStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}
