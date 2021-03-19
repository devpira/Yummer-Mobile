import 'package:flutter/material.dart';
import 'package:yummer/config/firebase_config.dart';
import 'package:yummer/config/theme.dart';
import 'package:yummer/config/app_values.dart';

class AppConfig extends InheritedWidget {
  final AppThemeData theme;
  final FirebaseConfig firebaseConfig;
  final AppValues values;

  const AppConfig({@required this.theme, @required this.firebaseConfig, @required this.values, @required  Widget child}): super(child: child);

  static AppConfig of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppConfig>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
