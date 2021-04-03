import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/domain/order_cart/models/order_cart_item_model.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/restaurant/bloc/restaurant_bloc.dart';

class RestaurantCheckoutItemRow extends StatelessWidget {
  final double height;
  final double width;

  final OrderCartItemModel orderCartItemModel;

  const RestaurantCheckoutItemRow({
    @required this.height,
    @required this.width,
    @required this.orderCartItemModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
        buildWhen: (previous, current) =>
            previous.restaurantModel != current.restaurantModel ||
            previous.menuModel != current.menuModel,
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(
              top: height * 0.01,
              bottom: height * 0.01,
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.05333,
                ),
                SizedBox(
                  height: width * 0.266666,
                  width: width * 0.266666,
                  child: CachedImage(
                    borderRadius: 10,
                    imageUrl: orderCartItemModel.imageUrls.isNotEmpty
                        ? orderCartItemModel.imageUrls[0]
                        : "https://health.clevelandclinic.org/wp-content/uploads/sites/3/2015/08/hotDogsWorstDiabetesFood-956129522-770x533-1.jpg",
                  ),
                ),
                SizedBox(
                  width: width * 0.042666,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderCartItemModel.name,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color:
                                AppConfig.of(context).theme.offsetHeadingColor),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "description",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                          "\$ ${(orderCartItemModel.priceUnitAmount / 100).toStringAsFixed(2)}",
                          style: TextStyle(
                              color:
                                  AppConfig.of(context).theme.offsetTextColor))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
