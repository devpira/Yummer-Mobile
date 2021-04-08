import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/feature.dart';
import 'package:yummer/presentation/features/restaurant/bloc/restaurant_bloc.dart';
import 'package:yummer/presentation/features/restaurant/views/restaurant_check_out_page/restaurant_cart_items_section.dart';
import 'package:yummer/routes/router.gr.dart';

class RestaurantCheckoutPage extends StatelessWidget {
  final RestaurantBloc restaurantBloc;

  const RestaurantCheckoutPage({
    @required this.restaurantBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: restaurantBloc,
        ),
        BlocProvider<MyWalletBloc>(
          create: (_) => getIt<MyWalletBloc>()
            ..add(const MyWalletEventLoadPaymentMethods()),
        ),
      ],
      child: _RestaurantCheckoutPage(),
    );
  }
}

class _RestaurantCheckoutPage extends StatelessWidget {
  Widget _buildSummaryRow(
      BuildContext context, String leftText, String rightText, bool bold) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontWeight: (bold) ? FontWeight.w700 : FontWeight.w300,
                  // color: AppConfig.of(context).theme.offsetHeadingColor,
                ),
          ),
          Text(
            rightText,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontWeight: (bold) ? FontWeight.w700 : FontWeight.w300,
                  // color: AppConfig.of(context).theme.offsetHeadingColor,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final checkoutCartProvider = Provider.of<RestaurantCheckoutCart>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Place Your Order",
          style: Theme.of(context).textTheme.headline5.copyWith(
              fontWeight: FontWeight.w900,
              color: AppConfig.of(context).theme.offsetHeadingColor),
        ),
        leading: Padding(
          padding: EdgeInsets.all(screenWidth * 0.012),
          child: const WhiteBackButton(shadow: 0),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, size) {
          final double height = size.maxHeight;
          final double width = size.maxWidth;

          return SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   color: AppConfig.of(context).theme.primaryColor,
                  //   height: MediaQuery.of(context).padding.top,
                  // ),
                  // SizedBox(height: height * 0.035),
                  // Center(
                  //   child: Text(
                  //     "We Are Hungry Too!",
                  //     style: Theme.of(context).textTheme.headline5.copyWith(
                  //         fontWeight: FontWeight.w900,
                  //         color:
                  //             AppConfig.of(context).theme.offsetHeadingColor),
                  //   ),
                  // ),
                  SizedBox(height: height * 0.015),
                  Container(
                    margin: EdgeInsets.only(
                        left: AppConfig.of(context).theme.pageLeftMarginP1 *
                            width),
                    child: Text(
                      "Your order",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.w400,
                            // color:
                            //     AppConfig.of(context).theme.offsetHeadingColor,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  RestaurantCartItemsSection(
                    height: height,
                    width: width,
                  ),
                  // SizedBox(
                  //   height: height * 0.01,
                  // ),
                  const Divider(),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal:
                          AppConfig.of(context).theme.pageLeftMarginP1 * width,
                    ),
                    child: Text(
                      "Summary",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    margin: EdgeInsets.only(
                      left:
                          AppConfig.of(context).theme.pageLeftMarginP1 * width,
                      right:
                          AppConfig.of(context).theme.pageLeftMarginP1 * width,
                    ),
                    decoration: BoxDecoration(
                      color: AppConfig.of(context).theme.primaryVeryLightColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenWidth * 0.03),
                      ),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "Summary",
                        //   style: Theme.of(context).textTheme.headline5.copyWith(
                        //         fontWeight: FontWeight.w400,
                        //         // color: AppConfig.of(context)
                        //         //     .theme
                        //         //     .offsetHeadingColor,
                        //       ),
                        // ),
                        // SizedBox(height: height * 0.02),
                        BlocBuilder<RestaurantBloc, RestaurantState>(
                            buildWhen: (previous, current) =>
                                previous.orderCartModel.totalPriceUnitAmount !=
                                current.orderCartModel.totalPriceUnitAmount,
                            builder: (context, state) {
                              return _buildSummaryRow(
                                  context,
                                  "Subtotal",
                                  "\$${state.orderCartModel.totalPriceUnitAmount / 100}",
                                  false);
                            }),
                        _buildSummaryRow(context, "Tax", "\$0.00", false),
                        _buildSummaryRow(context, "Tip", "\$0.00", false),
                        BlocBuilder<RestaurantBloc, RestaurantState>(
                          buildWhen: (previous, current) =>
                              previous.orderCartModel.totalPriceUnitAmount !=
                              current.orderCartModel.totalPriceUnitAmount,
                          builder: (context, state) {
                            return _buildSummaryRow(
                                context,
                                "Total",
                                "\$${state.orderCartModel.totalPriceUnitAmount / 100}",
                                true);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal:
                          AppConfig.of(context).theme.pageLeftMarginP1 * width,
                    ),
                    child: Text(
                      "Payment Information",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  // SizedBox(height: height * 0.01),
                  Container(
                    margin: EdgeInsets.only(
                      left:
                          AppConfig.of(context).theme.pageLeftMarginP1 * width,
                      right:
                          AppConfig.of(context).theme.pageLeftMarginP1 * width,
                    ),
                    // decoration: BoxDecoration(
                    //   // color: AppConfig.of(context).theme.primaryVeryLightColor,
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.all(
                    //     Radius.circular(screenWidth * 0.03),
                    //   ),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey.withOpacity(0.2),
                    //       spreadRadius: 2,
                    //       blurRadius: 8,
                    //       offset: const Offset(0, 3),
                    //     ),
                    //   ],
                    // ),
                    width: double.infinity,
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: _PaymentInformationSection(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    margin: EdgeInsets.only(
                      left:
                          AppConfig.of(context).theme.pageLeftMarginP1 * width,
                      right:
                          AppConfig.of(context).theme.pageLeftMarginP1 * width,
                    ),
                    child: BlocBuilder<MyWalletBloc, MyWalletState>(
                        buildWhen: (previous, current) =>
                            previous.defaultPaymentMethod !=
                            current.defaultPaymentMethod,
                        builder: (context, state) {
                          return AccentRaisedButton(
                            onClick: () {},
                            disableButton: state.defaultPaymentMethod == null,
                            text: "ORDER NOW",
                          );
                        }),
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PaymentInformationSection extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _PaymentInformationSection({
    @required this.screenHeight,
    @required this.screenWidth,
  });

  void onChangePaymentClicked(BuildContext context) {
    ExtendedNavigator.of(context).push(Routes.myWalletPage,
        arguments:
            MyWalletPageArguments(myWalletBloc: context.read<MyWalletBloc>()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyWalletBloc, MyWalletState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final cardPaymentMethodModel = state.defaultPaymentMethod;

          if (cardPaymentMethodModel == null) {
            return ListTile(
              onTap: () => onChangePaymentClicked(context),
              leading: Icon(
                FontAwesomeIcons.creditCard,
                color: AppConfig.of(context).theme.accentColor,
              ),
              dense: true,
              title: Row(
                children: [
                  const FittedBox(
                    child: Text(
                      "Click Here To Add A Payment Method",
                    ),
                  ),
                ],
              ),
            );
          }

          Widget leading = Icon(
            FontAwesomeIcons.creditCard,
            color: AppConfig.of(context).theme.accentColor,
          );

          String cardTypeText = "End With";

          if (cardPaymentMethodModel.brand == "visa") {
            leading = Icon(
              FontAwesomeIcons.ccVisa,
              color: AppConfig.of(context).theme.accentColor,
            );
            cardTypeText = "Visa";
          }

          if (cardPaymentMethodModel.brand == "mastercard") {
            leading = Icon(
              FontAwesomeIcons.ccMastercard,
              color: AppConfig.of(context).theme.accentColor,
            );
            cardTypeText = "Mastercard";
          }

          if (cardPaymentMethodModel.brand == "amex") {
            leading = Icon(
              FontAwesomeIcons.ccAmex,
              color: AppConfig.of(context).theme.accentColor,
            );

            cardTypeText = "Amex";
          }

          if (cardPaymentMethodModel.brand == "diners_club") {
            leading = Icon(
              FontAwesomeIcons.ccDinersClub,
              color: AppConfig.of(context).theme.accentColor,
            );
            cardTypeText = "Diners Club";
          }

          if (cardPaymentMethodModel.brand == "discover") {
            leading = Icon(
              FontAwesomeIcons.ccDiscover,
              color: AppConfig.of(context).theme.accentColor,
            );
            cardTypeText = "Discover";
          }

          if (cardPaymentMethodModel.brand == "jcb") {
            leading = Icon(
              FontAwesomeIcons.ccJcb,
              color: AppConfig.of(context).theme.accentColor,
            );
            cardTypeText = "JCB";
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Payment Information",
              //   style: Theme.of(context).textTheme.subtitle1.copyWith(
              //         fontWeight: FontWeight.w400,
              //       ),
              // ),
              ListTile(
                // onTap: () => {},
                contentPadding:
                    EdgeInsets.symmetric(vertical: screenHeight * 0.00),
                leading: leading,
                dense: true,
                trailing: FlatButton(
                  onPressed: () => onChangePaymentClicked(context),
                  child: const Text("Change"),
                ),
                title: Row(
                  children: [
                    Text(
                      "$cardTypeText  ${cardPaymentMethodModel.last4}",
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
