import 'package:flutter/material.dart';
import 'package:yummer/config/config.dart';

class MenuItemListTab extends StatelessWidget {
  final String text;
  final IconData iconData;
  final bool active;

  const MenuItemListTab({
    @required this.text,
    this.iconData,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    return Tab(
      child: Container(
        padding: (iconData == null)
            ? EdgeInsets.symmetric(horizontal: screenWidth * 0.05)
            : null,
        decoration: BoxDecoration(
            color: (active)
                ? AppConfig.of(context).theme.primaryColor
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.transparent, width: 2)),
        child: Align(
          child: (iconData == null) ? Text(text) : Icon(iconData),
        ),
      ),
    );
  }
}
