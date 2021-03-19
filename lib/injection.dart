import 'package:authentication_repository/authentication_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:yummer/injection.config.dart';

import 'config/config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configureInjection(String env) {
  $initGetIt(getIt, environment: env);
}

@module
abstract class ExternalLibraries {
  @lazySingleton
  AuthenticationRepository get authenticationRepository =>
      AuthenticationRepository(
        sendVerifyEmailConfig: SendVerifyEmailConfig(
          androidPackageName: getIt<AppValues>().androidPackageName,
          url: getIt<FirebaseConfig>().verifyEmailDeepLinkConfig.url,
          handleCodeInApp:
              getIt<FirebaseConfig>().verifyEmailDeepLinkConfig.handleCodeInApp,
          dynamicLinkDomain: getIt<FirebaseConfig>()
              .verifyEmailDeepLinkConfig
              .dynamicLinkDomain,
          androidInstallApp: getIt<FirebaseConfig>()
              .verifyEmailDeepLinkConfig
              .androidInstallApp,
          androidMinimumVersion: getIt<FirebaseConfig>()
              .verifyEmailDeepLinkConfig
              .androidMinimumVersion,
        ),
      );

  @lazySingleton
  Connectivity get connectivity => Connectivity();
}
