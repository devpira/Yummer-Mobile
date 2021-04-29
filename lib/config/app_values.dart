import 'package:injectable/injectable.dart';

@lazySingleton
class AppValues {
  String appName = "Yummer";
  String androidPackageName = "com.yummer.app.yummer";
  String graphQLUri = "http://192.168.0.125:4000/graphql";
  String deepLinkUri = "https://travelapp.page.link";
  String appInviteDeepLink = "https://travelapp.page.link/join";

  // Stripe values:
  String stripePublishableKey = "pk_test_51IHLekGq81Ii8kCy0SqeHGC3SKtmZbJ2z1YAiSgwFNmfnpAwVd03vKsHFRGDgFF50zBcQVYERCSWGOjqfBYJLmAb00uJxv355Z";
  String stripeMerchantId = "Test";
  String stripeAndroidPayMode = "test";
}
