// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../domain/menu/menu.dart';
import '../domain/my_wallet/models/card_payment_method_model.dart';
import '../presentation/core/core.dart';
import '../presentation/features/feature.dart';
import '../presentation/features/restaurant/bloc/restaurant_bloc.dart';

class Routes {
  static const String splashPage = '/';
  static const String loginPage = '/login-page';
  static const String createUserDetailsPage = '/create-user-details-page';
  static const String homePage = '/home-page';
  static const String restaurantPage = '/restaurant-page';
  static const String restaurantMenuItemPage = '/restaurant-menu-item-page';
  static const String restaurantCheckoutPage = '/restaurant-checkout-page';
  static const String myWalletPage = '/my-wallet-page';
  static const String myWalletAddCardPage = '/my-wallet-add-card-page';
  static const String myWalletEditCardPage = '/my-wallet-edit-card-page';
  static const String systemErrorPage = '/system-error-page';
  static const String loadingScreen = '/loading-screen';
  static const String noInternetPage = '/no-internet-page';
  static const all = <String>{
    splashPage,
    loginPage,
    createUserDetailsPage,
    homePage,
    restaurantPage,
    restaurantMenuItemPage,
    restaurantCheckoutPage,
    myWalletPage,
    myWalletAddCardPage,
    myWalletEditCardPage,
    systemErrorPage,
    loadingScreen,
    noInternetPage,
  };
}

class MyRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.createUserDetailsPage, page: CreateUserDetailsPage),
    RouteDef(Routes.homePage, page: HomePage),
    RouteDef(Routes.restaurantPage, page: RestaurantPage),
    RouteDef(Routes.restaurantMenuItemPage, page: RestaurantMenuItemPage),
    RouteDef(Routes.restaurantCheckoutPage, page: RestaurantCheckoutPage),
    RouteDef(Routes.myWalletPage, page: MyWalletPage),
    RouteDef(Routes.myWalletAddCardPage, page: MyWalletAddCardPage),
    RouteDef(Routes.myWalletEditCardPage, page: MyWalletEditCardPage),
    RouteDef(Routes.systemErrorPage, page: SystemErrorPage),
    RouteDef(Routes.loadingScreen, page: LoadingScreen),
    RouteDef(Routes.noInternetPage, page: NoInternetPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SplashPage(),
        settings: data,
      );
    },
    LoginPage: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    CreateUserDetailsPage: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CreateUserDetailsPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    HomePage: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    RestaurantPage: (data) {
      final args = data.getArgs<RestaurantPageArguments>(nullOk: false);
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            RestaurantPage(restaurantId: args.restaurantId),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    RestaurantMenuItemPage: (data) {
      final args = data.getArgs<RestaurantMenuItemPageArguments>(nullOk: false);
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            RestaurantMenuItemPage(
          productItem: args.productItem,
          restaurantBloc: args.restaurantBloc,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    RestaurantCheckoutPage: (data) {
      final args = data.getArgs<RestaurantCheckoutPageArguments>(nullOk: false);
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            RestaurantCheckoutPage(restaurantBloc: args.restaurantBloc),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    MyWalletPage: (data) {
      final args = data.getArgs<MyWalletPageArguments>(
        orElse: () => MyWalletPageArguments(),
      );
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MyWalletPage(myWalletBloc: args.myWalletBloc),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    MyWalletAddCardPage: (data) {
      final args = data.getArgs<MyWalletAddCardPageArguments>(nullOk: false);
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MyWalletAddCardPage(myWalletBloc: args.myWalletBloc),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    MyWalletEditCardPage: (data) {
      final args = data.getArgs<MyWalletEditCardPageArguments>(nullOk: false);
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MyWalletEditCardPage(
          myWalletBloc: args.myWalletBloc,
          cardPaymentMethodModel: args.cardPaymentMethodModel,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    SystemErrorPage: (data) {
      final args = data.getArgs<SystemErrorPageArguments>(
        orElse: () => SystemErrorPageArguments(),
      );
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SystemErrorPage(
          key: args.key,
          errorMessage: args.errorMessage,
          tryAgainFunction: args.tryAgainFunction,
          showLogOut: args.showLogOut,
        ),
        settings: data,
      );
    },
    LoadingScreen: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LoadingScreen(),
        settings: data,
      );
    },
    NoInternetPage: (data) {
      final args = data.getArgs<NoInternetPageArguments>(
        orElse: () => NoInternetPageArguments(),
      );
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) => NoInternetPage(
          key: args.key,
          tryAgainFunction: args.tryAgainFunction,
          showLogOut: args.showLogOut,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// RestaurantPage arguments holder class
class RestaurantPageArguments {
  final String restaurantId;
  RestaurantPageArguments({@required this.restaurantId});
}

/// RestaurantMenuItemPage arguments holder class
class RestaurantMenuItemPageArguments {
  final MenuProductModel productItem;
  final RestaurantBloc restaurantBloc;
  RestaurantMenuItemPageArguments(
      {@required this.productItem, @required this.restaurantBloc});
}

/// RestaurantCheckoutPage arguments holder class
class RestaurantCheckoutPageArguments {
  final RestaurantBloc restaurantBloc;
  RestaurantCheckoutPageArguments({@required this.restaurantBloc});
}

/// MyWalletPage arguments holder class
class MyWalletPageArguments {
  final MyWalletBloc myWalletBloc;
  MyWalletPageArguments({this.myWalletBloc});
}

/// MyWalletAddCardPage arguments holder class
class MyWalletAddCardPageArguments {
  final MyWalletBloc myWalletBloc;
  MyWalletAddCardPageArguments({@required this.myWalletBloc});
}

/// MyWalletEditCardPage arguments holder class
class MyWalletEditCardPageArguments {
  final MyWalletBloc myWalletBloc;
  final CardPaymentMethodModel cardPaymentMethodModel;
  MyWalletEditCardPageArguments(
      {@required this.myWalletBloc, @required this.cardPaymentMethodModel});
}

/// SystemErrorPage arguments holder class
class SystemErrorPageArguments {
  final Key key;
  final String errorMessage;
  final Function tryAgainFunction;
  final bool showLogOut;
  SystemErrorPageArguments(
      {this.key,
      this.errorMessage,
      this.tryAgainFunction,
      this.showLogOut = false});
}

/// NoInternetPage arguments holder class
class NoInternetPageArguments {
  final Key key;
  final Function tryAgainFunction;
  final bool showLogOut;
  NoInternetPageArguments(
      {this.key, this.tryAgainFunction, this.showLogOut = false});
}
