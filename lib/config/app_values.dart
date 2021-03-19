import 'package:injectable/injectable.dart';

@lazySingleton
class AppValues {
  String appName = "Yummer";
  String androidPackageName = "com.yummer.app.yummer";
  String graphQLUri = "http://192.168.0.110:4000/graphql";
  String deepLinkUri = "https://travelapp.page.link";
  String appInviteDeepLink = "https://travelapp.page.link/join";
}
