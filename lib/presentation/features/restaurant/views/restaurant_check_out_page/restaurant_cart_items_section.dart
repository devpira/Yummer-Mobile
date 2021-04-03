import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/presentation/features/restaurant/bloc/restaurant_bloc.dart';

import 'restaurant_checkout_item_row.dart';

class RestaurantCartItemsSection extends StatelessWidget {
  final double height;
  final double width;

  const RestaurantCartItemsSection({
    @required this.height,
    @required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
        buildWhen: (previous, current) =>
            previous.orderCartModel != current.orderCartModel,
        builder: (context, state) {
          final cartItems = state.orderCartModel.cartItems;
          return Column(
            children: cartItems
                .map((orderCartItemModel) => RestaurantCheckoutItemRow(
                      height: height,
                      width: width,
                      orderCartItemModel: orderCartItemModel,
                    ),)
                .toList(),
            // child: CustomScrollView(
            //   slivers: <Widget>[
            //     SliverList(
            //       delegate: SliverChildBuilderDelegate(
            //         (BuildContext ctx, int index) {
            //           if (index == 0) {
            //             return SizedBox(
            //               height: height * 0.01,
            //             );
            //           }
            //           // add padding to end of list:
            //           if (index == cartItems.length + 1) {
            //             return SizedBox(
            //               height: height * 0.01,
            //             );
            //           }
            //           if (index > cartItems.length + 1) return null;
            //           return RestaurantCheckoutItemRow(
            //             height: height,
            //             width: width,
            //             orderCartItemModel: cartItems[index - 1],
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          );
        });
  }
}
