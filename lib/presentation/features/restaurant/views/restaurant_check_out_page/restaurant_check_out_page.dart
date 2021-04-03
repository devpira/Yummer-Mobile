import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/restaurant/bloc/restaurant_bloc.dart';
import 'package:yummer/presentation/features/restaurant/views/restaurant_check_out_page/restaurant_cart_items_section.dart';

class RestaurantCheckoutPage extends StatelessWidget {
  final RestaurantBloc restaurantBloc;

  const RestaurantCheckoutPage({
    @required this.restaurantBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: restaurantBloc,
      child: _RestaurantCheckoutPage(),
    );
  }
}

class _RestaurantCheckoutPage extends StatefulWidget {
  @override
  __RestaurantCheckoutPageState createState() =>
      __RestaurantCheckoutPageState();
}

class __RestaurantCheckoutPageState extends State<_RestaurantCheckoutPage> {
  @override
  initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51H13noIsKLKzx3TGbUfpU0jjgyxckBtfjifsisB3ULBB9VGLXHj8ty91kPo4SphtMcn49jN8FfoEiQ1ewSuSJbbW00OsuXmGZq",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

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
                color: AppConfig.of(context).theme.offsetHeadingColor),
          ),
          Text(
            rightText,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: (bold) ? FontWeight.w700 : FontWeight.w300,
                color: AppConfig.of(context).theme.offsetHeadingColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final checkoutCartProvider = Provider.of<RestaurantCheckoutCart>(context);
    //final screenHeight = MediaQuery.of(context).size.height;
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
                          color:
                              AppConfig.of(context).theme.offsetHeadingColor),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  RestaurantCartItemsSection(
                    height: height,
                    width: width,
                  ),

                  Container(
                    margin: EdgeInsets.only(
                      left:
                          AppConfig.of(context).theme.pageLeftMarginP1 * width,
                      right:
                          AppConfig.of(context).theme.pageLeftMarginP1 * width,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.02),
                        Text(
                          "Summary",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppConfig.of(context)
                                  .theme
                                  .offsetHeadingColor),
                        ),
                        SizedBox(height: height * 0.02),
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
                            }),
                        // _buildSummaryRow(
                        //     context,
                        //     "Total",
                        //     "\$23.45",
                        //     // "\$" +
                        //     //     checkoutCartProvider.totalCost
                        //     //         .toStringAsFixed(2)
                        //     //         .toString(),
                        //     true),
                        SizedBox(height: height * 0.04),
                        AccentRaisedButton(
                          onClick: () {
                            StripePayment.paymentRequestWithCardForm(
                                    CardFormPaymentRequest())
                                .then((paymentMethod) {
                              print(paymentMethod.id);
                              print(paymentMethod.customerId);
                              print(paymentMethod.card.funding);
                              // _scaffoldKey.currentState.showSnackBar(SnackBar(
                              //     content:
                              //         Text('Received ${paymentMethod.id}')));
                              // setState(() {
                              //   _paymentMethod = paymentMethod;
                              // });
                            }).catchError((error) => print(error));
                          },
                          text: "Checkout",
                        ),
                        SizedBox(height: height * 0.04),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // RestaurantBottomButton(
            //   height: height,
            //   width: width,
            //   child: Text(
            //     "ORDER NOW",
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onClick: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (_) => Scaffold(
            //           body: Container(
            //             height: double.infinity,
            //             child: Center(
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Container(
            //                     height: height * 0.275,
            //                     width: double.infinity,
            //                     decoration: const BoxDecoration(
            //                       image: DecorationImage(
            //                         fit: BoxFit.contain,
            //                         image: const AssetImage(
            //                             "assets/images/trollface.jpg"),
            //                       ),
            //                     ),
            //                   ),
            //                   Text("JK This meal is on you...thanks")
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // )
          );
        },
      ),
    );
  }
}
