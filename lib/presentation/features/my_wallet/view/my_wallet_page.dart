import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/domain/my_wallet/models/card_payment_method_model.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/presentation/features/feature.dart';
import 'package:yummer/routes/router.gr.dart';

class MyWalletPage extends StatelessWidget {
  final MyWalletBloc? myWalletBloc;
  const MyWalletPage({this.myWalletBloc});

  @override
  Widget build(BuildContext context) {
    if (myWalletBloc != null) {
      print("CAME HERE");
      return BlocProvider.value(
        value: myWalletBloc!,
        child: _MyWalletPage(),
      );
    } else {
      return BlocProvider<MyWalletBloc>(
        create: (_) =>
            getIt<MyWalletBloc>()..add(const MyWalletEventLoadPaymentMethods()),
        child: _MyWalletPage(),
      );
    }
  }
}

class _MyWalletPage extends StatelessWidget {
  void onAddCardClicked(BuildContext context) {
    AutoRouter.of(context).push(MyWalletAddCardPageRoute(
      myWalletBloc: context.read<MyWalletBloc>(),
    ));
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
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
      ),
      body: BlocListener<MyWalletBloc, MyWalletState>(
        listener: (context, state) {
          print("STATE LISTEN CHANGED");
          if (state.errorMessage != null) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                ),
              );
          }
        },
        child: BlocBuilder<MyWalletBloc, MyWalletState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              print("STATE CHANGED");
              if ((state.cardPaymentMethods == null &&
                      state.isFetchInProgress) ||
                  state.showLoading) {
                return LoadingScreen();
              } else if (state.showNoInternetError) {
                return const NoInternetPage();
              } else if (state.cardPaymentMethods != null) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      if (state.cardPaymentMethods!.isNotEmpty)
                        _DefaultPaymentMethodSection(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              "Payment Methods",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
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
                                          color: AppConfig.of(context)!
                                              .theme!
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
                  ),
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

class _DefaultPaymentMethodSection extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _DefaultPaymentMethodSection({
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyWalletBloc, MyWalletState>(
      buildWhen: (previous, current) =>
          previous.defaultPaymentMethod != current.defaultPaymentMethod ||
          previous.cardPaymentMethods != current.cardPaymentMethods,
      builder: (context, state) {
        print("STATE RELOAD");
        print(state.defaultPaymentMethod);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Text(
                "Default Payment Method",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            if (state.defaultPaymentMethod != null)
              CreditCardItem(cardPaymentMethodModel: state.defaultPaymentMethod)
            else
              SizedBox(
                width: double.infinity,
                child: Column(children: [
                  const Text("Please add a default payment method"),
                ]),
              ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
          ],
        );
      },
    );
  }
}

class _CardPaymentMethodList extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _CardPaymentMethodList({
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyWalletBloc, MyWalletState>(
      buildWhen: (previous, current) =>
          previous.cardPaymentMethods != current.cardPaymentMethods,
      builder: (context, state) {
        print("CARD PAYMENTS CHANGED!");
        return Column(
            children: state.cardPaymentMethods!
                .map(
                  (item) => _CardPaymentMethodRow(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    cardPaymentMethodModel: item,
                  ),
                )
                .toList());
      },
    );
  }
}

class _CardPaymentMethodRow extends StatelessWidget {
  final CardPaymentMethodModel? cardPaymentMethodModel;
  final double screenHeight;
  final double screenWidth;

  const _CardPaymentMethodRow({
    required this.screenHeight,
    required this.screenWidth,
    required this.cardPaymentMethodModel,
  });

  void onEditCardClicked(BuildContext context) {
    AutoRouter.of(context).push(MyWalletEditCardPageRoute(
      myWalletBloc: context.read<MyWalletBloc>(),
      cardPaymentMethodModel: cardPaymentMethodModel!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget leading = const Icon(FontAwesomeIcons.creditCard);

    if (cardPaymentMethodModel!.brand == "visa") {
      leading = const Icon(FontAwesomeIcons.ccVisa);
    }

    if (cardPaymentMethodModel!.brand == "mastercard") {
      leading = const Icon(FontAwesomeIcons.ccMastercard);
    }

    if (cardPaymentMethodModel!.brand == "amex") {
      leading = const Icon(FontAwesomeIcons.ccAmex);
    }

    if (cardPaymentMethodModel!.brand == "diners_club") {
      leading = const Icon(FontAwesomeIcons.ccDinersClub);
    }

    if (cardPaymentMethodModel!.brand == "discover") {
      leading = const Icon(FontAwesomeIcons.ccDiscover);
    }

    if (cardPaymentMethodModel!.brand == "jcb") {
      leading = const Icon(FontAwesomeIcons.ccJcb);
    }

    return ListTile(
      onTap: () => onEditCardClicked(context),
      leading: leading,
      trailing: const Icon(Icons.edit),
      title: Row(
        children: [
          Text(
            "****${cardPaymentMethodModel!.last4}",
          ),
          if (cardPaymentMethodModel!.isDefault!)
            SizedBox(width: screenWidth * 0.05),
          if (cardPaymentMethodModel!.isDefault!)
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.lightBlue[200],
              child: SizedBox(
                  height: screenHeight * 0.015,
                  child: const FittedBox(
                    child: Text("Default",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
            ),
          // SizedBox(width: screenWidth * 0.05),
          // const Chip(
          //   labelPadding: EdgeInsets.all(2),
          //   label: FittedBox(child: Text("Default")),
          // )
        ],
      ),
    );
  }
}
