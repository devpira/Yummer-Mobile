import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/restaurant_order_session/bloc/restaurant_order_session_bloc.dart';

class RestaurantOrderSessionPage extends StatelessWidget {
  const RestaurantOrderSessionPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestaurantOrderSessionBloc>(
        create: (_) => getIt<RestaurantOrderSessionBloc>(),
        child: _RestaurantOrderSessionPage());
  }
}

class _RestaurantOrderSessionPage extends StatelessWidget {
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
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.07,
          ),
          Text(
            "We have received your order.",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppConfig.of(context)!.theme!.offsetHeadingColor),
          ),
          Text(
            "Please wait for the restaurant to confirm.",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppConfig.of(context)!.theme!.offsetHeadingColor),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            //width: width * 0.6,
            child: Center(
              child: Image.asset(
                "assets/images/order_session_confirm.png",
                // width: width * 0.6,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: AccentRaisedButton(
              onClick: () {},
              text: "ORDER MORE",
            ),
          )
        ],
      ),
    );
  }
}
