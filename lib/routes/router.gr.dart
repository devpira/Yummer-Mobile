// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../presentation/core/authentication/authentication.dart';
import '../presentation/core/splash_screen/splash_screen.dart';

class Routes {
  static const String splashPage = '/';
  static const String loginPage = '/login-page';
  static const String signUpPage = '/sign-up-page';
  static const String forgotPasswordPage = '/forgot-password-page';
  static const String verifyEmailPage = '/verify-email-page';
  static const all = <String>{
    splashPage,
    loginPage,
    signUpPage,
    forgotPasswordPage,
    verifyEmailPage,
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
  };
}
