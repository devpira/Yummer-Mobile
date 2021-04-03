import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yummer/config/app_config.dart';
import 'package:yummer/domain/menu/menu.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/restaurant/bloc/restaurant_bloc.dart';
import 'package:yummer/presentation/features/restaurant/views/restaurant_page/restaurant_checkout_cart_bar.dart';

import 'menu_item_list_tab.dart';
import 'menu_item_list_tab_bar.dart';
import 'restaurant_display_group_view.dart';

class RestaurantPage extends StatelessWidget {
  final String restaurantId;
  const RestaurantPage({
    @required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestaurantBloc>(
      create: (_) => getIt<RestaurantBloc>()
        ..add(RestaurantEventLoadRestaurant(restaurantId: restaurantId))
        ..add(RestaurantEventLoadMenu(restaurantId: restaurantId))
        ..add(RestaurantEventLoadCart(restaurantId: restaurantId)),
      child: const _RestaurantView(),
    );
  }
}

class _RestaurantView extends StatelessWidget {
  const _RestaurantView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.isRestaurantFetchInProgress) {
            return LoadingScreen();
          } else if (state.restaurantModel != null) {
            return _LoadedRestaurantView(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            );
          } else {
            //replace with error screen:
            return Container();
          }
        },
      ),
    );
  }
}

class _LoadedRestaurantView extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _LoadedRestaurantView({
    @required this.screenHeight,
    @required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      buildWhen: (previous, current) =>
          previous.restaurantModel != current.restaurantModel ||
          previous.isMenuFetchInProgress != current.isMenuFetchInProgress ||
          previous.menuModel != current.menuModel,
      builder: (context, state) {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  expandedHeight: screenHeight * 0.4,
                  backgroundColor: Colors.white,
                  leading: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.012),
                    child: const WhiteBackButton(shadow: 0),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.share,
                      ),
                    )
                  ],
                  flexibleSpace: LayoutBuilder(
                    builder: (context, BoxConstraints constraint) {
                      final double top = constraint.biggest.height;
                      final contraintWidth = constraint.maxWidth;
                      final contraintHeigth = constraint.maxHeight;
                      return FlexibleSpaceBar(
                        title: AnimatedOpacity(
                          duration: const Duration(milliseconds: 50),
                          opacity: top < 85.0 ? 1.0 : 0.0,
                          // opacity: 1.0,
                          child: Text(state.restaurantModel.name),
                        ),
                        centerTitle: true,
                        background: SizedBox(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: contraintHeigth * 0.65,
                                child: Image.network(
                                  'https://www.brampton.ca/EN/Arts-Culture-Tourism/Tourism-Brampton/Visitors/PublishingImages/Tourism%20Strategy%202020/PageBanner-FoodTourism.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _CardInfo(
                                    top: top,
                                    screenHeight: contraintHeigth,
                                    screenWidth: contraintWidth,
                                  ),
                                  SizedBox(
                                    height: contraintHeigth * 0.03,
                                  ),
                                  if (state.menuModel != null)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: contraintWidth * 0.055,
                                          ),
                                          child: Text(
                                            // "Menu - ${state.menuModel.name}",
                                            "Menu",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppConfig.of(context)
                                                        .theme
                                                        .offsetHeadingColor),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: contraintWidth * 0.03),
                                          child: FlatButton(
                                              onPressed: () {},
                                              child: const Text("Browse All")),
                                        )
                                      ],
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (state.menuModel != null)
                BlocBuilder<RestaurantBloc, RestaurantState>(
                    buildWhen: (previous, current) =>
                        previous.menuModel != current.menuModel ||
                        previous.currentTabIndex != current.currentTabIndex,
                    builder: (context, state) {
                      return _MenuTabs(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        currentIndex: state.currentTabIndex,
                        displayGroups: state.menuModel.displayGroups
                            .map((group) => group.name)
                            .toList(),
                      );
                    }),
            ];
          },
          body: _RestaurantBody(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
          ),
        );
      },
    );
  }
}

class _CardInfo extends StatelessWidget {
  final double top;
  final double screenHeight;
  final double screenWidth;

  const _CardInfo({
    @required this.top,
    @required this.screenHeight,
    @required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      buildWhen: (previous, current) =>
          previous.restaurantModel != current.restaurantModel,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
            top: screenHeight * 0.4,
            left: screenWidth * 0.05333,
            right: screenWidth * 0.05333,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenWidth * 0.05),
                topRight: Radius.circular(screenWidth * 0.05),
                bottomLeft: Radius.circular(screenWidth * 0.05),
                bottomRight: Radius.circular(screenWidth * 0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Container(
            height: screenHeight * 0.4,
            width: screenWidth,
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.036),
            margin: EdgeInsets.only(
              left: screenWidth * 0.04,
              right: screenWidth * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  //"BRUNCH HEAVEN",
                  state.restaurantModel.name,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppConfig.of(context).theme.offsetHeadingColor),
                ),
                if (top > 200)
                  Text(
                    // "AMERICAN - PANCAKES",
                    state.restaurantModel.description,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                if (top > 200)
                  Text(
                    //"Leslieville's favourite comfort-brunch spot",
                    "${state.restaurantModel.addressLine1}, ${state.restaurantModel.city}, ${state.restaurantModel.stateProvince}, ${state.restaurantModel.country}",
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: AppConfig.of(context).theme.offsetHeadingColor),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MenuTabs extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final List<String> displayGroups;
  final int currentIndex;

  const _MenuTabs({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.displayGroups,
    @required this.currentIndex,
  });

  @override
  __MenuTabsState createState() => __MenuTabsState();
}

class __MenuTabsState extends State<_MenuTabs>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: widget.displayGroups.length, vsync: this);

    _controller.animation.addListener(() {
      context.read<RestaurantBloc>().add(RestaurantEventChangeCurrentMenuTab(
          index: (_controller.animation.value).round()));
      // setState(() {
      //   _currentIndex = (_controller.animation.value).round();
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.index = widget.currentIndex;
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        minHeight: widget.screenHeight * 0.05,
        maxHeight: widget.screenHeight * 0.05,
        child: MenuItemListTabBar(
          tighten: true,
          tabController: _controller,
          tabList: widget.displayGroups
              .map(
                (name) => MenuItemListTab(
                  text: name,
                  active:
                      widget.currentIndex == widget.displayGroups.indexOf(name),
                ),
              )
              .toList(),
        ),
      ),
      pinned: true,
    );
  }
}

class _RestaurantBody extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _RestaurantBody({
    @required this.screenHeight,
    @required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      buildWhen: (previous, current) =>
          previous.isMenuFetchInProgress != current.isMenuFetchInProgress ||
          previous.menuModel != current.menuModel ||
          previous.orderCartModel != current.orderCartModel ||
          previous.currentTabIndex != current.currentTabIndex,
      builder: (context, state) {
        if (state.isMenuFetchInProgress) {
          return LoadingScreen();
        } else if (state.menuModel != null) {
          return Stack(
            children: [
              _RestaurantTabBarView(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                displayGroups: state.menuModel.displayGroups,
                currentIndex: state.currentTabIndex,
              ),
              if (state.orderCartModel.cartItems.length > 0)
                RestaurantCheckoutCartBar(
                  height: screenHeight,
                  width: screenWidth,
                  orderCartModel: state.orderCartModel,
                )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _RestaurantTabBarView extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final List<MenuDisplayGroupModel> displayGroups;
  final int currentIndex;

  const _RestaurantTabBarView({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.displayGroups,
    @required this.currentIndex,
  });

  @override
  __RestaurantTabBarViewState createState() => __RestaurantTabBarViewState();
}

class __RestaurantTabBarViewState extends State<_RestaurantTabBarView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: widget.displayGroups.length, vsync: this);

    _controller.animation.addListener(() {
      context.read<RestaurantBloc>().add(RestaurantEventChangeCurrentMenuTab(
          index: (_controller.animation.value).round()));
      // setState(() {
      //   _currentIndex = (_controller.animation.value).round();
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.index = widget.currentIndex;
    return Container(
      margin: EdgeInsets.only(top: widget.screenHeight * 0.12),
      child: TabBarView(
          controller: _controller,
          children: widget.displayGroups
              .map(
                (MenuDisplayGroupModel menu) => RestaurantDisplayGroupView(
                  height: widget.screenHeight,
                  width: widget.screenWidth,
                  displayGroup: menu,
                ),
              )
              .toList()),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: Container(color: Colors.white, child: child));
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
