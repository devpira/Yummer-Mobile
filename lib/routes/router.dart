import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/presentation/features/feature.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    AutoRoute(page: SplashPage, initial: true),
    CustomRoute<bool>(page: LoginPage, transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute<bool>(page: CreateUserDetailsPage, transitionsBuilder: TransitionsBuilders.fadeIn),

     CustomRoute<bool>(page: HomePage, transitionsBuilder: TransitionsBuilders.fadeIn),

    //Core routes:
    CustomRoute<bool>(page: SystemErrorPage),
    CustomRoute<bool>(page: LoadingScreen),
    CustomRoute<bool>(page: NoInternetPage),
  ],
)
class $MyRouter {}
