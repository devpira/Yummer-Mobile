import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/feature.dart';

class RestaurantOrderSessionPage extends StatelessWidget {
  const RestaurantOrderSessionPage();

  @override
  Widget build(BuildContext context) {
    return _RestaurantOrderSessionPage();
  }
}

class _RestaurantOrderSessionPage extends StatelessWidget {
  Widget _buildSummaryRow(
      BuildContext context, String leftText, String rightText, bool bold) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: (bold) ? FontWeight.w700 : FontWeight.w300,
                  // color: AppConfig.of(context).theme.offsetHeadingColor,
                ),
          ),
          Text(
            rightText,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Dining Status",
          style: Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: FontWeight.w900,
              color: AppConfig.of(context)!.theme!.offsetHeadingColor),
        ),
        leading: Padding(
          padding: EdgeInsets.all(screenWidth * 0.012),
          child: const WhiteBackButton(shadow: 0),
        ),
      ),
      body: BlocBuilder<RestaurantOrderSessionBloc,
              RestaurantOrderSessionState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state.orderSessionModel == null) {
              return LoadingScreen();
            }
            print(state.orderSessionModel);
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text(
                          "Your Pending Orders:",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppConfig.of(context)!
                                      .theme!
                                      .offsetHeadingColor),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: screenWidth * 0.03,
                              bottom: screenHeight * 0.02),
                          child: Text("Order 1",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                  )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(screenWidth * 0.03),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.all(0),
                          child: Column(
                            children: state.orderSessionModel!.orderItems
                                .map((item) => Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              screenWidth * 0.05),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: screenWidth * 0.06,
                                                width: screenWidth * 0.06,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                        screenWidth * 0.01),
                                                  ),
                                                ),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    item.quantity.toString(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.05,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.product.name!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1!
                                                          .copyWith(
                                                              color: AppConfig.of(
                                                                      context)!
                                                                  .theme!
                                                                  .offsetHeadingColor),
                                                    ),
                                                    Text(
                                                      item.product.description!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.15,
                                                child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        "\$${(item.originalPriceUnitAmount / 100).toStringAsFixed(2)}")),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (state.orderSessionModel!.orderItems
                                                .indexOf(item) !=
                                            state.orderSessionModel!.orderItems
                                                    .length -
                                                1)
                                          const Divider(),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        Text(
                          "Order Summary:",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppConfig.of(context)!
                                      .theme!
                                      .offsetHeadingColor),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(screenWidth * 0.03),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.05),
                            child: Column(
                              children: [
                                _buildSummaryRow(
                                    context,
                                    "Subtotal",
                                    "\$${state.orderSessionModel!.totalCostUnitAmount! / 100}",
                                    false),
                                _buildSummaryRow(
                                    context, "Tax", "\$0.00", false),
                                _buildSummaryRow(
                                    context, "Tip", "\$0.00", false),
                                _buildSummaryRow(
                                  context,
                                  "Total",
                                  "\$${state.orderSessionModel!.totalCostUnitAmount! / 100}",
                                  true,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.25,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenHeight * 0.02),
                    child: AccentRaisedButton(
                      onClick: () {},
                      text: "ORDER MORE",
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
