import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppThemeData {
  final ThemeData appThemeData = ThemeData(
    primaryColor: const Color(0xffff8e45),
    backgroundColor: const Color(0xffFAFAFA),
    accentColor: const Color(0xFF314B69),
    colorScheme: const ColorScheme.light(
      primary: Color(0xffff8e45),
      surface: Color(0xffff8e45),
      onSurface: Color(0xffff8e45),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    // fontFamily: 'Montserrat'
  );

  final Color primaryColor = const Color(0xffff8e45);
  final Color accentColor = const Color(0xFF314B69);
  final Color offsetColor = const Color(0xffff8e45);
  final Color primaryButtonColor = const Color(0xffff8e45);
  final Color offsetHeadingColor = const Color(0xFF314B69);

  final Color lightGreyBackground = const Color(0xFFF9F9F9);
  final Color greyBackground = const Color(0xFFDADADA);
  final Color greyTextColor = const Color(0xFF929292);

  final Color whiteBackgroundColor = const Color(0xffFAFAFA);
  final Color unselectedNavBottomItemColor = Colors.blueGrey[300];

  final Color offsetTextColor = const Color(0xFF314B69);

  final Color captionTextColor = const Color(0xFFBDBDBD);

  final Color textFieldOneBackgroundColor = const Color(0xFFF6F6F6);

  final double pageLeftMarginP1 = 0.0533;
}
