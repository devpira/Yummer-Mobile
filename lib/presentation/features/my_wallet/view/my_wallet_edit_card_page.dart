import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yummer/domain/my_wallet/models/card_payment_method_model.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/presentation/features/feature.dart';

class MyWalletEditCardPage extends StatelessWidget {
  final MyWalletBloc myWalletBloc;
  final CardPaymentMethodModel cardPaymentMethodModel;

  const MyWalletEditCardPage({
    required this.myWalletBloc,
    required this.cardPaymentMethodModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: myWalletBloc,
      child: _MyWalletAddCardPage(
        cardPaymentMethodModel: cardPaymentMethodModel,
      ),
    );
  }
}

class _MyWalletAddCardPage extends StatelessWidget {
  final CardPaymentMethodModel cardPaymentMethodModel;

  const _MyWalletAddCardPage({
    required this.cardPaymentMethodModel,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final userDetails = context.select(
        (UserDetailBloc bloc) => (bloc.state as UserDetailLoaded).userDetails);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

        title: Text(
          "Edit Card",
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        actions: [
          if (cardPaymentMethodModel.isDefault!)
            Container(
              margin: EdgeInsets.only(right: screenWidth * 0.05),
              child: const Chip(
                label: Text("Default"),
              ),
            )
        ],
        // leading: Padding(
        //   padding: EdgeInsets.all(screenWidth * 0.012),
        //   child: const WhiteBackButton(shadow: 0),
        // ),
      ),
      body: BlocListener<MyWalletBloc, MyWalletState>(
        listener: (context, state) {},
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              CreditCardItem(cardPaymentMethodModel: cardPaymentMethodModel),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Column(
                  children: [
                    if (cardPaymentMethodModel.isDefault!) const Divider(),
                    if (!cardPaymentMethodModel.isDefault!)
                      ListTile(
                        onTap: () {
                          context.read<MyWalletBloc>().add(
                                MyWalletEventChangeDefaultMethod(
                                  cardPaymentMethodModel:
                                      cardPaymentMethodModel,
                                ),
                              );
                          Navigator.pop(context);
                        },
                        leading: const Icon(FontAwesomeIcons.edit),
                        title: const Text(
                          "Make Default",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    const Divider(),
                    ListTile(
                      onTap: () {
                        context.read<MyWalletBloc>().add(
                              MyWalletEventRemoveCardMethod(
                                  cardPaymentMethodModel:
                                      cardPaymentMethodModel,
                                  posCustomerId: userDetails.posCustomerId),
                            );
                        Navigator.pop(context);
                      },
                      leading: const Icon(FontAwesomeIcons.solidTrashAlt,
                          color: Colors.red),
                      title: const Text(
                        "Remove payment method",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                    ),
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
