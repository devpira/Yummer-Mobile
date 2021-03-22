import 'package:flutter/material.dart';
import 'package:yummer/config/config.dart';

import 'menu_item_list_tab.dart';

class MenuItemListTabBar extends PreferredSize {
  final List<MenuItemListTab> tabList;
  final TabController tabController;
  final bool isScrollable;
  final bool tighten;

  const MenuItemListTabBar({
    @required this.tabList,
    this.tabController,
    this.isScrollable = true,
    this.tighten = false,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;
    final screenWidth = mediaQueryData.size.width;

    return Container(
      width: double.infinity,
      margin: (tighten && !isScrollable)
          ? EdgeInsets.only(
              bottom: screenHeight * 0.01,
              left: screenWidth * 0.02,
              right: screenWidth * 0.02,
            )
          : EdgeInsets.only(
              bottom: screenHeight * 0.01,
            ),
      height: screenHeight * 0.04,
      child: TabBar(
        controller: tabController,
        labelPadding:
            tighten ? EdgeInsets.only(left: screenWidth * 0.03) : null,
        unselectedLabelColor: AppConfig.of(context).theme.greyTextColor,
        labelColor: Colors.white,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          //  color: RestaurantConfig.of(context).theme.primaryColor
        ),
        tabs: tabList,
        isScrollable: isScrollable,
      ),
    );
  }
}
