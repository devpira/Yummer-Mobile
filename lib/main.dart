import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';

import 'package:yummer/config/config.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/presentation/features/feature.dart';
import 'package:yummer/routes/router.gr.dart';

import 'injection.dart';

final _appRouter = MyRouter();

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

  await initHiveForFlutter();

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
        BlocProvider<UserDetailBloc>(
          create: (_) => getIt<UserDetailBloc>(),
        ),
        BlocProvider<ErrorHandlingBloc>(
          create: (_) => getIt<ErrorHandlingBloc>(),
        ),
        BlocProvider<InternetConnectivityCubit>(
          create: (_) => getIt<InternetConnectivityCubit>(),
        ),
        BlocProvider<RestaurantOrderSessionBloc>(
          create: (_) => getIt<RestaurantOrderSessionBloc>(),
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
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Yummer',
    //   theme: AppThemeData().appThemeData,
    //   builder: ExtendedNavigator.builder(
    //     navigatorKey: const GlobalObjectKey("nav.key"),
    //     router: MyRouter(),
    //     initialRoute: Routes.splashPage,
    //     builder: (context, child) {
    //
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      title: 'Travel Bug',
      theme: AppThemeData().appThemeData,
      builder: (context, child) {
        return MultiBlocListener(
          listeners: [
            BlocListener<ErrorHandlingBloc, ErrorHandlingState>(
              listener: (context, state) {
                if (state is ErrorHandlingNewErrorOccurred) {
                  _appRouter.replace(
                    SystemErrorPageRoute(
                      errorMessage: state.errorMessage!,
                      tryAgainFunction: state.tryAgainFunction!,
                      showLogOut: true,
                    ),
                  );
                }
              },
            ),
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                print(state.status.toString());
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    context.read<UserDetailBloc>().add(
                          UserDetailLoadRequested(user: state.user),
                        );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    // Clear the user details when user logged out:
                    context
                        .read<UserDetailBloc>()
                        .add(UserDetailRemoveRequested());
                    _appRouter.pushAndRemoveUntil(
                      const LoginPageRoute(),
                      predicate: (route)=> false,
                    );
                    break;
                  default:
                    break;
                }
              },
            ),
            BlocListener<UserDetailBloc, UserDetailState>(
              listener: (context, state) {
                if (state is UserDetailLoaded && !state.isRefresh!) {
                  print("cammmmme here @@@@");
                  _appRouter.replace(
                    const HomePageRoute(),
                  );
                    //       _appRouter.pushAndRemoveUntil(
                    //   const HomePageRoute(),
                    //   predicate: (route)=> false,
                    // );
                } else if (state is UserDetailLoading) {
                  _appRouter.replace(
                    const LoadingScreenRoute(),
                  );
                } else if (state is UserDetailLoadFailed) {
                  context.read<ErrorHandlingBloc>().emitSystemError(
                      errorMessage: state.errorMessage,
                      tryAgainFunction: () =>
                          context.read<UserDetailBloc>().add(
                                UserDetailLoadRequested(user: state.user),
                              ));
                } else if (state is UserDetailNotCreated) {
                  _appRouter.replace(
                    const CreateUserDetailsPageRoute(),
                  );
                } else if (state is UserDetailLoadLostInternet) {
                  _appRouter.replace(
                    NoInternetPageRoute(),
                  );
                }
              },
            ),
          ],
          child: child!,
        );
      },
    );
  }
}
