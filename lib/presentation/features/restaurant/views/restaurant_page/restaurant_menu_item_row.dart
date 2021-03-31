import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/domain/menu/menu.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/routes/router.gr.dart';

class RestaurantMenuItemRow extends StatelessWidget {
  final double height;
  final double width;

  final MenuProductModel productItem;

  const RestaurantMenuItemRow({
    @required this.height,
    @required this.width,
    @required this.productItem,
  });

  // void addToCart(RestaurantCheckoutCart checkoutCartProvider) {
  //   print("Added to cart clicked");
  //   checkoutCartProvider.addItem(productItem);
  // }

  void onProductClicked(BuildContext context) {
    print("CLICKED");
    ExtendedNavigator.of(context).push(
      Routes.restaurantMenuItemPage,
      arguments: RestaurantMenuItemPageArguments(
        productItem: productItem,
      ),
    );
  }

  // void subtractFromCart(RestaurantCheckoutCart checkoutCartProvider) {
  //   checkoutCartProvider.subractItem(productItem);
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onProductClicked(context),
      child: Container(
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
            Hero(
              tag: productItem.id,
              child: SizedBox(
                height: width * 0.266666,
                width: width * 0.266666,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),

                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: NetworkImage(
                  //     productItem.imageUrls.length > 0
                  //         ? productItem.imageUrls[0]
                  //         : "https://health.clevelandclinic.org/wp-content/uploads/sites/3/2015/08/hotDogsWorstDiabetesFood-956129522-770x533-1.jpg",
                  //   ),
                  // ),
                // ),
                child: CachedImage(
                  borderRadius: 10,
                  imageUrl: productItem.imageUrls.length > 0
                      ? productItem.imageUrls[0]
                      : "https://health.clevelandclinic.org/wp-content/uploads/sites/3/2015/08/hotDogsWorstDiabetesFood-956129522-770x533-1.jpg",
                ),
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
                    productItem.name,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: AppConfig.of(context).theme.offsetHeadingColor),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    productItem.description,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                      "\$ ${(productItem.priceUnitAmount / 100).toStringAsFixed(2)}",
                      style: TextStyle(
                          color: AppConfig.of(context).theme.offsetTextColor))
                ],
              ),
            ),
            // (productItem.quantity == 0)
            //     ? Container(
            //         width: width * 0.18933,
            //         height: height * 0.035,
            //         margin: EdgeInsets.only(right: width * 0.02133),
            //         child: RaisedButton(
            //             elevation: 0,
            //             color: RestaurantConfig.of(context)
            //                 .theme
            //                 .whiteBackgroundColor,
            //             textColor:
            //                 RestaurantConfig.of(context).theme.primaryColor,
            //             child: FittedBox(
            //               child: Text(
            //                 "Add",
            //                 style: TextStyle(fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(30.0),
            //                 side: BorderSide(
            //                     color: RestaurantConfig.of(context)
            //                         .theme
            //                         .primaryColor)),
            //             onPressed: () => addToCart(checkoutCartProvider)),
            //       )
            //     : PlusTextMinusButtons(
            //         height: height,
            //         width: width,
            //         text: productItem.quantity.toString(),
            //         onMinusClicked: () =>
            //             subtractFromCart(checkoutCartProvider),
            //         onPlusClicked: () => addToCart(checkoutCartProvider),
            //       )
          ],
        ),
      ),
    );
  }
}
