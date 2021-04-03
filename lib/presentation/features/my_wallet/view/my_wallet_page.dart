import 'package:auto_route/auto_route.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/presentation/features/feature.dart';
import 'package:yummer/routes/router.gr.dart';

class MyWalletPage extends StatelessWidget {
  const MyWalletPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyWalletBloc>(
      create: (_) =>
          getIt<MyWalletBloc>()..add(const MyWalletEventLoadPaymentMethods()),
      child: _MyWalletPage(),
    );
  }
}

class _MyWalletPage extends StatelessWidget {
  void onAddCardClicked(BuildContext context) {
    ExtendedNavigator.of(context).push(
      Routes.myWalletAddCardPage,
      arguments: MyWalletAddCardPageArguments(
        myWalletBloc: context.read<MyWalletBloc>(),
      ),
    );
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
          "My Wallet",
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        // leading: Padding(
        //   padding: EdgeInsets.all(screenWidth * 0.012),
        //   child: const WhiteBackButton(shadow: 0),
        // ),
      ),
      body: BlocListener<MyWalletBloc, MyWalletState>(
        listener: (context, state) {
          // if (state.status.isSubmissionFailure) {
          //   Scaffold.of(context)
          //     ..hideCurrentSnackBar()
          //     ..showSnackBar(
          //       SnackBar(
          //         content: Text(state.errorMessage),
          //       ),
          //     );
          // } else if (state.status.isSubmissionSuccess) {
          //   context
          //       .read<UserDetailBloc>()
          //       .add(UserDetailLoadRequested(user: user));
          // }
        },
        child: BlocBuilder<MyWalletBloc, MyWalletState>(
            buildWhen: (previous, current) =>
                previous.isFetchInProgress != current.isFetchInProgress ||
                previous.cardPaymentMethods != current.cardPaymentMethods,
            builder: (context, state) {
              if (state.cardPaymentMethods == null && state.isFetchInProgress) {
                return LoadingScreen();
              } else if (state.showNoInternetError) {
                return const NoInternetPage();
              } else if (state.cardPaymentMethods != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Text(
                        "Default Payment Method",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    CreditCard(
                      cardNumber: "**** **** **** 7854",
                      // cardExpiry: "10/25",
                      // cardHolderName: "Card Holder",
                      cvv: "456",

                      bankName: "Axis Bank",
                      cardType: CardType
                          .masterCard, // Optional if you want to override Card Type
                      // showBackSide: false,
                      frontBackground: CardBackgrounds.black,
                      backBackground: CardBackgrounds.white,
                      showShadow: true,

                      // textExpDate: 'Exp. Date',
                      // textName: 'Name',
                      // textExpiry: 'MM/YY',
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Text(
                            "Payment Methods",
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          _CardPaymentMethodList(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          ),
                          const Divider(),
                          InkWell(
                            onTap: () => onAddCardClicked(context),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ),
                                    Icon(FontAwesomeIcons.plusCircle,
                                        color: AppConfig.of(context)
                                            .theme
                                            .primaryColor),
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    const Text("Add a payment card"),
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ],
                );
              }
              {
                return const SystemErrorPage(
                  errorMessage:
                      "Unexpected error occurred. Please try again later",
                );
              }
            }),
      ),
    );
  }
}

class _CardPaymentMethodList extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _CardPaymentMethodList({
    @required this.screenHeight,
    @required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyWalletBloc, MyWalletState>(
      buildWhen: (previous, current) =>
          previous.cardPaymentMethods != current.cardPaymentMethods,
      builder: (context, state) {
        return Column(
            children: state.cardPaymentMethods
                .map((item) => Text(item.last4))
                .toList());
      },
    );
  }
}
