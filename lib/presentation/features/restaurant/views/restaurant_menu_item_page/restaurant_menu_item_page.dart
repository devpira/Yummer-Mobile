import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/config/config.dart';

import 'package:yummer/domain/menu/menu.dart';
import 'package:yummer/presentation/core_widgets/buttons/buttons.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/restaurant/bloc/restaurant_bloc.dart';

class RestaurantMenuItemPage extends StatelessWidget {
  final RestaurantBloc restaurantBloc;
  final MenuProductModel productItem;

  const RestaurantMenuItemPage({
    required this.productItem,
    required this.restaurantBloc,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: restaurantBloc,
      child: _RestaurantMenuItemView(productItem: productItem),
    );
  }
}

class _RestaurantMenuItemView extends StatelessWidget {
  final MenuProductModel productItem;

  const _RestaurantMenuItemView({
    required this.productItem,
  });
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // These are the slivers that show up in the "outer" scroll view.
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                pinned: true,
                elevation: 3,
                expandedHeight: screenHeight * 0.4,
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.012),
                  child: const WhiteBackButton(shadow: 0),
                ),
                flexibleSpace: LayoutBuilder(
                  builder: (context, BoxConstraints constraint) {
                    final double top = constraint.biggest.height;
                    // final contraintWidth = constraint.maxWidth;
                    // final contraintHeigth = constraint.maxHeight;
                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 50),
                        opacity: top < 85.0 ? 1.0 : 0.0,
                        // opacity: 1.0,
                        // child: Text(state.restaurantModel.name),
                      ),
                      centerTitle: true,
                      background: SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Hero(
                              tag: productItem.id!,
                              child: SizedBox(
                                width: double.infinity,
                                height: screenWidth,
                                child: CachedImage(
                                  borderRadius: 30,
                                  imageUrl: productItem.imageUrls.length > 0
                                      ? productItem.imageUrls[0]
                                      : "https://health.clevelandclinic.org/wp-content/uploads/sites/3/2015/08/hotDogsWorstDiabetesFood-956129522-770x533-1.jpg",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.12,
                  ),
                  Text(
                    productItem.name!,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: AppConfig.of(context)!.theme!.offsetHeadingColor,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productItem.description!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: productItem.modiferGroups
                        .map(
                          (ProductModifierGroupModel item) => Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ListTileTheme(
                              dense: true,
                              tileColor: AppConfig.of(context)!
                                  .theme!
                                  .lightGreyBackground,
                              child: ExpansionTile(
                                maintainState: true,
                                initiallyExpanded: true,
                                title: Text("Choice of ${item.name}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppConfig.of(context)!
                                              .theme!
                                              .offsetHeadingColor,
                                        )),
                                subtitle: Text(
                                    item.minSelection == 0
                                        ? "Optional"
                                        : "Required - Min (${item.minSelection}) Max (${item.maxSelection})",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontWeight: FontWeight.w400)),
                                children: [
                                  if (item.minSelection == 1 &&
                                      item.maxSelection == 1)
                                    RadioButtonGroup(
                                        activeColor: AppConfig.of(context)!
                                            .theme!
                                            .primaryColor,
                                        labels: item.modifiers
                                            .map((ProductModifierModel item) =>
                                                item.name)
                                            .toList(),
                                        onSelected: (String? selected) =>
                                            print(selected))
                                  else
                                    CheckboxGroup(
                                      activeColor: AppConfig.of(context)!
                                          .theme!
                                          .primaryColor,
                                      labels: item.modifiers
                                          .map((ProductModifierModel item) =>
                                              item.name)
                                          .toList(),
                                      onSelected: (List<String?> checked) =>
                                          print(
                                        checked.toString(),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ListTileTheme(
                      dense: true,
                      tileColor:
                          AppConfig.of(context)!.theme!.lightGreyBackground,
                      child: ExpansionTile(
                        maintainState: true,
                        initiallyExpanded: true,
                        title: Text(
                          "Leave a Note",
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppConfig.of(context)!
                                    .theme!
                                    .offsetHeadingColor,
                              ),
                        ),
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                              horizontal: screenWidth * 0.05,
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: screenWidth * 0.04,
                                    right: screenWidth * 0.04,
                                    top: screenHeight * 0.022,
                                    bottom: screenHeight * 0.022),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppConfig.of(context)!
                                          .theme!
                                          .primaryColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),

                                hintText: "Enter any note for the server",
                                // errorText: errorText,
                              ),
                              textInputAction: TextInputAction.done,
                              minLines: 4,
                              maxLines: 5,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.12,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.03),
                child: AccentRaisedButton(
                  onClick: () {
                    context.read<RestaurantBloc>().add(
                        RestaurantEventAddToCart(productItem: productItem));
                        Navigator.pop(context);
                  },
                  elevation: 7,
                  text: "ADD TO CART (\$${productItem.priceUnitAmount! / 100})",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
