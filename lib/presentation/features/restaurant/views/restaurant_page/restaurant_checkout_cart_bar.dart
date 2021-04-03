import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/domain/order_cart/models/order_cart_model.dart';
import 'package:yummer/presentation/features/restaurant/bloc/restaurant_bloc.dart';
import 'package:yummer/routes/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantCheckoutCartBar extends StatelessWidget {
  final double width;
  final double height;
  final OrderCartModel orderCartModel;

  const RestaurantCheckoutCartBar({
    @required this.height,
    @required this.width,
    @required this.orderCartModel,
  });

  @override
  Widget build(BuildContext context) {
    return _RestaurantBottomButton(
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            color: AppConfig.of(context).theme.primaryColor,
            margin: const EdgeInsets.only(
                // top: height * 0.169951,
                //  left: width * 0.05333,
                //  right: width * 0.05333,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 0,
            child: Container(
              width: width * 0.08,
              height: width * 0.08,
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  orderCartModel.cartItems.length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const Text(
            "CHECKOUT",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "\$${orderCartModel.totalPriceUnitAmount / 100}",
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class _RestaurantBottomButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const _RestaurantBottomButton({
    @required this.height,
    @required this.width,
    @required this.child,
  });

  void onCheckoutClicked(BuildContext context) {
    print("CLICKED");
    ExtendedNavigator.of(context).push(Routes.restaurantCheckoutPage, arguments: RestaurantCheckoutPageArguments(restaurantBloc: context.read<RestaurantBloc>()));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.053333, vertical: height * 0.025862),
        width: double.infinity,
        height: height * 0.062807,
        decoration: BoxDecoration(
          color: AppConfig.of(context).theme.accentColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width * 0.025),
              topRight: Radius.circular(width * 0.025),
              bottomLeft: Radius.circular(width * 0.025),
              bottomRight: Radius.circular(width * 0.025)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: RaisedButton(
          color: Colors.transparent,
          splashColor: Colors.white30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          onPressed: () => onCheckoutClicked(context),
          child: child,
        ),
      ),
    );
  }
}
