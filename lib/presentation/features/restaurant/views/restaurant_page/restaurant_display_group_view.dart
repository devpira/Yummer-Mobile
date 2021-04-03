import 'package:flutter/material.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/domain/menu/menu.dart';

import 'restaurant_menu_item_row.dart';

class RestaurantDisplayGroupView extends StatelessWidget {
  final double height;
  final double width;
  final MenuDisplayGroupModel displayGroup;

  const RestaurantDisplayGroupView({
    @required this.height,
    @required this.width,
    @required this.displayGroup,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext ctx, int index) {
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: width * 0.0533, bottom: height * 0.01),
                    child: Text(
                      displayGroup.name,
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppConfig.of(context)
                              .theme
                              .offsetHeadingColor),
                    ),
                  );
                }
                // add padding to end of list:
                if (index == displayGroup.products.length + 1) {
                  return SizedBox(
                    height: height * 0.12,
                  );
                }
                if (index > displayGroup.products.length + 1) return null;
                return RestaurantMenuItemRow(
                  height: height,
                  width: width,
                  productItem: displayGroup.products[index - 1],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
