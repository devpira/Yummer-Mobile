// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/widgets.dart' as _i7;
import 'package:yummer/domain/menu/menu.dart' as _i4;
import 'package:yummer/domain/my_wallet/models/card_payment_method_model.dart'
    as _i6;
import 'package:yummer/presentation/core/core.dart' as _i2;
import 'package:yummer/presentation/features/feature.dart' as _i3;
import 'package:yummer/presentation/features/restaurant/bloc/restaurant_bloc.dart'
    as _i5;

class MyRouter extends _i1.RootStackRouter {
  MyRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashPageRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i2.SplashPage());
    },
    LoginPageRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i2.LoginPage(),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    CreateUserDetailsPageRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: const _i3.CreateUserDetailsPage(),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    HomePageRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i3.HomePage(),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    RestaurantPageRoute.name: (entry) {
      var args = entry.routeData.argsAs<RestaurantPageRouteArgs>();
      return _i1.CustomPage(
          entry: entry,
          child: _i3.RestaurantPage(restaurantId: args.restaurantId),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    RestaurantMenuItemPageRoute.name: (entry) {
      var args = entry.routeData.argsAs<RestaurantMenuItemPageRouteArgs>();
      return _i1.CustomPage(
          entry: entry,
          child: _i3.RestaurantMenuItemPage(
              productItem: args.productItem,
              restaurantBloc: args.restaurantBloc),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    RestaurantCheckoutPageRoute.name: (entry) {
      var args = entry.routeData.argsAs<RestaurantCheckoutPageRouteArgs>();
      return _i1.CustomPage(
          entry: entry,
          child:
              _i3.RestaurantCheckoutPage(restaurantBloc: args.restaurantBloc),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    RestaurantOrderSessionPageRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i3.RestaurantOrderSessionPage(),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    MyWalletPageRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<MyWalletPageRouteArgs>(orElse: () => MyWalletPageRouteArgs());
      return _i1.CustomPage(
          entry: entry,
          child: _i3.MyWalletPage(myWalletBloc: args.myWalletBloc),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    MyWalletAddCardPageRoute.name: (entry) {
      var args = entry.routeData.argsAs<MyWalletAddCardPageRouteArgs>();
      return _i1.CustomPage(
          entry: entry,
          child: _i3.MyWalletAddCardPage(myWalletBloc: args.myWalletBloc),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    MyWalletEditCardPageRoute.name: (entry) {
      var args = entry.routeData.argsAs<MyWalletEditCardPageRouteArgs>();
      return _i1.CustomPage(
          entry: entry,
          child: _i3.MyWalletEditCardPage(
              myWalletBloc: args.myWalletBloc,
              cardPaymentMethodModel: args.cardPaymentMethodModel),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    SystemErrorPageRoute.name: (entry) {
      var args = entry.routeData.argsAs<SystemErrorPageRouteArgs>(
          orElse: () => SystemErrorPageRouteArgs());
      return _i1.CustomPage(
          entry: entry,
          child: _i2.SystemErrorPage(
              key: args.key,
              errorMessage: args.errorMessage,
              tryAgainFunction: args.tryAgainFunction,
              showLogOut: args.showLogOut),
          opaque: true,
          barrierDismissible: false);
    },
    LoadingScreenRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i2.LoadingScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    NoInternetPageRoute.name: (entry) {
      var args = entry.routeData.argsAs<NoInternetPageRouteArgs>(
          orElse: () => NoInternetPageRouteArgs());
      return _i1.CustomPage(
          entry: entry,
          child: _i2.NoInternetPage(
              key: args.key,
              tryAgainFunction: args.tryAgainFunction,
              showLogOut: args.showLogOut),
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashPageRoute.name, path: '/'),
        _i1.RouteConfig(LoginPageRoute.name, path: '/login-page'),
        _i1.RouteConfig(CreateUserDetailsPageRoute.name,
            path: '/create-user-details-page'),
        _i1.RouteConfig(HomePageRoute.name, path: '/home-page'),
        _i1.RouteConfig(RestaurantPageRoute.name, path: '/restaurant-page'),
        _i1.RouteConfig(RestaurantMenuItemPageRoute.name,
            path: '/restaurant-menu-item-page'),
        _i1.RouteConfig(RestaurantCheckoutPageRoute.name,
            path: '/restaurant-checkout-page'),
        _i1.RouteConfig(RestaurantOrderSessionPageRoute.name,
            path: '/restaurant-order-session-page'),
        _i1.RouteConfig(MyWalletPageRoute.name, path: '/my-wallet-page'),
        _i1.RouteConfig(MyWalletAddCardPageRoute.name,
            path: '/my-wallet-add-card-page'),
        _i1.RouteConfig(MyWalletEditCardPageRoute.name,
            path: '/my-wallet-edit-card-page'),
        _i1.RouteConfig(SystemErrorPageRoute.name, path: '/system-error-page'),
        _i1.RouteConfig(LoadingScreenRoute.name, path: '/loading-screen'),
        _i1.RouteConfig(NoInternetPageRoute.name, path: '/no-internet-page')
      ];
}

class SplashPageRoute extends _i1.PageRouteInfo {
  const SplashPageRoute() : super(name, path: '/');

  static const String name = 'SplashPageRoute';
}

class LoginPageRoute extends _i1.PageRouteInfo {
  const LoginPageRoute() : super(name, path: '/login-page');

  static const String name = 'LoginPageRoute';
}

class CreateUserDetailsPageRoute extends _i1.PageRouteInfo {
  const CreateUserDetailsPageRoute()
      : super(name, path: '/create-user-details-page');

  static const String name = 'CreateUserDetailsPageRoute';
}

class HomePageRoute extends _i1.PageRouteInfo {
  const HomePageRoute() : super(name, path: '/home-page');

  static const String name = 'HomePageRoute';
}

class RestaurantPageRoute extends _i1.PageRouteInfo<RestaurantPageRouteArgs> {
  RestaurantPageRoute({required String restaurantId})
      : super(name,
            path: '/restaurant-page',
            args: RestaurantPageRouteArgs(restaurantId: restaurantId));

  static const String name = 'RestaurantPageRoute';
}

class RestaurantPageRouteArgs {
  const RestaurantPageRouteArgs({required this.restaurantId});

  final String restaurantId;
}

class RestaurantMenuItemPageRoute
    extends _i1.PageRouteInfo<RestaurantMenuItemPageRouteArgs> {
  RestaurantMenuItemPageRoute(
      {required _i4.MenuProductModel productItem,
      required _i5.RestaurantBloc restaurantBloc})
      : super(name,
            path: '/restaurant-menu-item-page',
            args: RestaurantMenuItemPageRouteArgs(
                productItem: productItem, restaurantBloc: restaurantBloc));

  static const String name = 'RestaurantMenuItemPageRoute';
}

class RestaurantMenuItemPageRouteArgs {
  const RestaurantMenuItemPageRouteArgs(
      {required this.productItem, required this.restaurantBloc});

  final _i4.MenuProductModel productItem;

  final _i5.RestaurantBloc restaurantBloc;
}

class RestaurantCheckoutPageRoute
    extends _i1.PageRouteInfo<RestaurantCheckoutPageRouteArgs> {
  RestaurantCheckoutPageRoute({required _i5.RestaurantBloc restaurantBloc})
      : super(name,
            path: '/restaurant-checkout-page',
            args: RestaurantCheckoutPageRouteArgs(
                restaurantBloc: restaurantBloc));

  static const String name = 'RestaurantCheckoutPageRoute';
}

class RestaurantCheckoutPageRouteArgs {
  const RestaurantCheckoutPageRouteArgs({required this.restaurantBloc});

  final _i5.RestaurantBloc restaurantBloc;
}

class RestaurantOrderSessionPageRoute extends _i1.PageRouteInfo {
  const RestaurantOrderSessionPageRoute()
      : super(name, path: '/restaurant-order-session-page');

  static const String name = 'RestaurantOrderSessionPageRoute';
}

class MyWalletPageRoute extends _i1.PageRouteInfo<MyWalletPageRouteArgs> {
  MyWalletPageRoute({_i3.MyWalletBloc? myWalletBloc})
      : super(name,
            path: '/my-wallet-page',
            args: MyWalletPageRouteArgs(myWalletBloc: myWalletBloc));

  static const String name = 'MyWalletPageRoute';
}

class MyWalletPageRouteArgs {
  const MyWalletPageRouteArgs({this.myWalletBloc});

  final _i3.MyWalletBloc? myWalletBloc;
}

class MyWalletAddCardPageRoute
    extends _i1.PageRouteInfo<MyWalletAddCardPageRouteArgs> {
  MyWalletAddCardPageRoute({required _i3.MyWalletBloc myWalletBloc})
      : super(name,
            path: '/my-wallet-add-card-page',
            args: MyWalletAddCardPageRouteArgs(myWalletBloc: myWalletBloc));

  static const String name = 'MyWalletAddCardPageRoute';
}

class MyWalletAddCardPageRouteArgs {
  const MyWalletAddCardPageRouteArgs({required this.myWalletBloc});

  final _i3.MyWalletBloc myWalletBloc;
}

class MyWalletEditCardPageRoute
    extends _i1.PageRouteInfo<MyWalletEditCardPageRouteArgs> {
  MyWalletEditCardPageRoute(
      {required _i3.MyWalletBloc myWalletBloc,
      required _i6.CardPaymentMethodModel cardPaymentMethodModel})
      : super(name,
            path: '/my-wallet-edit-card-page',
            args: MyWalletEditCardPageRouteArgs(
                myWalletBloc: myWalletBloc,
                cardPaymentMethodModel: cardPaymentMethodModel));

  static const String name = 'MyWalletEditCardPageRoute';
}

class MyWalletEditCardPageRouteArgs {
  const MyWalletEditCardPageRouteArgs(
      {required this.myWalletBloc, required this.cardPaymentMethodModel});

  final _i3.MyWalletBloc myWalletBloc;

  final _i6.CardPaymentMethodModel cardPaymentMethodModel;
}

class SystemErrorPageRoute extends _i1.PageRouteInfo<SystemErrorPageRouteArgs> {
  SystemErrorPageRoute(
      {_i7.Key? key,
      String? errorMessage,
      Function? tryAgainFunction,
      bool showLogOut = false})
      : super(name,
            path: '/system-error-page',
            args: SystemErrorPageRouteArgs(
                key: key,
                errorMessage: errorMessage,
                tryAgainFunction: tryAgainFunction,
                showLogOut: showLogOut));

  static const String name = 'SystemErrorPageRoute';
}

class SystemErrorPageRouteArgs {
  const SystemErrorPageRouteArgs(
      {this.key,
      this.errorMessage,
      this.tryAgainFunction,
      this.showLogOut = false});

  final _i7.Key? key;

  final String? errorMessage;

  final Function? tryAgainFunction;

  final bool showLogOut;
}

class LoadingScreenRoute extends _i1.PageRouteInfo {
  const LoadingScreenRoute() : super(name, path: '/loading-screen');

  static const String name = 'LoadingScreenRoute';
}

class NoInternetPageRoute extends _i1.PageRouteInfo<NoInternetPageRouteArgs> {
  NoInternetPageRoute(
      {_i7.Key? key, Function? tryAgainFunction, bool showLogOut = false})
      : super(name,
            path: '/no-internet-page',
            args: NoInternetPageRouteArgs(
                key: key,
                tryAgainFunction: tryAgainFunction,
                showLogOut: showLogOut));

  static const String name = 'NoInternetPageRoute';
}

class NoInternetPageRouteArgs {
  const NoInternetPageRouteArgs(
      {this.key, this.tryAgainFunction, this.showLogOut = false});

  final _i7.Key? key;

  final Function? tryAgainFunction;

  final bool showLogOut;
}
