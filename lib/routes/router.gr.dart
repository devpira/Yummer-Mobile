// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../presentation/core/core.dart';
import '../presentation/features/feature.dart';

class Routes {
  static const String splashPage = '/';
  static const String loginPage = '/login-page';
  static const String signUpPage = '/sign-up-page';
  static const String forgotPasswordPage = '/forgot-password-page';
  static const String verifyEmailPage = '/verify-email-page';
  static const String createUserDetailsPage = '/create-user-details-page';
  static const String homePage = '/home-page';
  static const String systemErrorPage = '/system-error-page';
  static const String loadingScreen = '/loading-screen';
  static const String noInternetPage = '/no-internet-page';
  static const all = <String>{
    splashPage,
    loginPage,
    signUpPage,
    forgotPasswordPage,
    verifyEmailPage,
    createUserDetailsPage,
    homePage,
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
    RouteDef(Routes.signUpPage, page: SignUpPage),
    RouteDef(Routes.forgotPasswordPage, page: ForgotPasswordPage),
    RouteDef(Routes.verifyEmailPage, page: VerifyEmailPage),
    RouteDef(Routes.createUserDetailsPage, page: CreateUserDetailsPage),
    RouteDef(Routes.homePage, page: HomePage),
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
    SignUpPage: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SignUpPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
    ForgotPasswordPage: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ForgotPasswordPage(),
        settings: data,
      );
    },
    VerifyEmailPage: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const VerifyEmailPage(),
        settings: data,
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
