import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core/splash_screen/splash_screen.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    AutoRoute(page: SplashPage, initial: true),
    CustomRoute<bool>(page: LoginPage),
    CustomRoute<bool>(page: SignUpPage, transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute<bool>(page: ForgotPasswordPage),
    CustomRoute<bool>(page: VerifyEmailPage),
  ],
)
class $MyRouter {}
