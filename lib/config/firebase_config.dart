
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseConfig {
  final _FirebaseVerifyEmailConfigLink verifyEmailDeepLinkConfig =
      _FirebaseVerifyEmailConfigLink();
  
}

class _FirebaseVerifyEmailConfigLink {
  // for sending firebase email verificaiton code
  final String url = "https://travelbug.page.link/verifyemail";
  final bool handleCodeInApp = true;
  final String dynamicLinkDomain = "travelbug.page.link";
  final bool androidInstallApp = true;
  final String androidMinimumVersion = "12";
}
