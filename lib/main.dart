import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/config/app_values.dart';
import 'package:yummer/config/firebase_config.dart';
import 'package:yummer/config/theme.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/routes/router.gr.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure inection:
  configureInjection(Environment.prod);

  //Restrict phone orientiation to Portrait:
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Following changes the app top status bar color:
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await Firebase.initializeApp();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => getIt<AuthenticationBloc>(),
        ),
      ],
      child: AppConfig(
        theme: getIt<AppThemeData>(),
        values: getIt<AppValues>(),
        firebaseConfig: getIt<FirebaseConfig>(),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yummer',
      theme: AppThemeData().appThemeData,
      builder: ExtendedNavigator.builder(
        router: MyRouter(),
        initialRoute: Routes.splashPage,
        builder: (context, child) {
          return MultiBlocListener(
            listeners: [
              // BlocListener<ErrorHandlingBloc, ErrorHandlingState>(
              //   listener: (context, state) {
              //     if (state is ErrorHandlingNewErrorOccurred) {
              //       ExtendedNavigator.root.pushAndRemoveUntil<void>(
              //         Routes.systemErrorPage,
              //         (route) => false,
              //         arguments: SystemErrorPageArguments(
              //           errorMessage: state.errorMessage,
              //           tryAgainFunction: state.tryAgainFunction,
              //           showLogOut: true,
              //         ),
              //       );
              //     }
              //   },
              // ),
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  print(state.status.toString());
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      // context.read<UserDetailBloc>().add(
                      //       UserDetailLoadRequested(user: state.user),
                      //     );
                      break;
                    case AuthenticationStatus.authenticatedEmailNotVerifed:
                      ExtendedNavigator.root.pushAndRemoveUntil<void>(
                        Routes.verifyEmailPage,
                        (route) => false,
                      );
                      break;
                    case AuthenticationStatus.unauthenticated:
                      // Clear the user details when user logged out:
                      // context
                      //     .read<UserDetailBloc>()
                      //     .add(UserDetailRemoveRequested());
                      ExtendedNavigator.root.pushAndRemoveUntil<void>(
                        Routes.loginPage,
                        (route) => false,
                      );
                      break;
                    default:
                      break;
                  }
                },
              ),
              // BlocListener<UserDetailBloc, UserDetailState>(
              //   listener: (context, state) {
              //     if (state is UserDetailLoaded) {
              //       ExtendedNavigator.root.pushAndRemoveUntil<void>(
              //         Routes.homePage,
              //         (route) => false,
              //       );
              //     } else if (state is UserDetailLoading) {
              //       ExtendedNavigator.root.pushAndRemoveUntil<void>(
              //         Routes.loadingScreen,
              //         (route) => false,
              //       );
              //     } else if (state is UserDetailLoadFailed) {
              //       context.read<ErrorHandlingBloc>().emitSystemError(
              //           errorMessage: state.errorMessage,
              //           tryAgainFunction: () =>
              //               context.read<UserDetailBloc>().add(
              //                     UserDetailLoadRequested(user: state.user),
              //                   ));
              //     } else if (state is UserDetailNotCreated) {
              //       ExtendedNavigator.root.pushAndRemoveUntil<void>(
              //         Routes.createUserDetailsPage,
              //         (route) => false,
              //       );
              //     } else if (state is UserDetailLoadLostInternet) {
              //       ExtendedNavigator.root.pushAndRemoveUntil<void>(
              //         Routes.noInternetPage,
              //         (route) => false,
              //       );
              //     }
              //   },
              // ),
            ],
            child: child,
          );
        },
      ),
    );
  }
}
