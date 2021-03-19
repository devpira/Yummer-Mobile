# yummer

yummer application

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Generate flutter files
flutter pub run build_runner watch --delete-conflicting-outputs
flutter pub run build_runner build --delete-conflicting-outputs

## Getting sha keys
https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google

cd android
./gradlew signingReport or gradlew signingReport

removing recaptacha for firebase phone auth:
https://www.youtube.com/watch?v=opBwTxicw1k

IOS TODO:
1. setup phone auth
2. Test phone auth, ensure time out sends back to enter phone page