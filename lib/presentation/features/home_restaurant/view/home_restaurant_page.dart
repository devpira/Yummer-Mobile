import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yummer/config/app_config.dart';
import 'package:yummer/domain/restaurant/models/basic_restaurant_model.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/home_restaurant/bloc/home_restaurant_bloc.dart';
import 'package:yummer/routes/router.gr.dart';

class HomeRestaurantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeRestaurantBloc>(
      create: (_) => getIt<HomeRestaurantBloc>(),
      child: const _HomeRestaurantView(),
    );
  }
}

class _HomeRestaurantView extends StatelessWidget {
  const _HomeRestaurantView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppConfig.of(context).theme.greyBackground,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, size) {
        final double height = size.maxHeight;
        final double width = size.maxWidth;
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  // pinned: true,
                  elevation: 0,
                  expandedHeight: height * 0.16,
                  backgroundColor: Colors.white,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, BoxConstraints constraint) {
                      final double top = constraint.biggest.height;
                      print(size.biggest.height);
                      return FlexibleSpaceBar(
                        title: AnimatedOpacity(
                          duration: const Duration(milliseconds: 50),
                          opacity: top < 85.0 ? 1.0 : 0.0,
                          // opacity: 1.0,
                        ),
                        //title: Text("My Brand Shop"),
                        centerTitle: true,
                        background: SizedBox(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: height * 0.08,
                              left: width * 0.053,
                              right: width * 0.053,
                            ),
                            child: Column(
                              children: [
                                _SearchRestuarantInput(
                                  screenHeight: height,
                                  screenWidth: width,
                                ),
                                // Row(
                                //   children: [
                                //     _buildIconButton(
                                //         context: context,
                                //         screenHeight: height,
                                //         screenWidth: width,
                                //         label: "Map",
                                //         width: width * 0.25,
                                //         iconData: FontAwesomeIcons.mapMarked),
                                //     SizedBox(
                                //       width: width * 0.05,
                                //     ),
                                //     _buildIconButton(
                                //       context: context,
                                //       screenHeight: height,
                                //       screenWidth: width,
                                //       label: "Filter",
                                //       width: width * 0.25,
                                //       iconData: FontAwesomeIcons.filter,
                                //     )
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // SliverPersistentHeader(
              //   delegate: _SliverAppBarDelegate(
              //     minHeight: height * 0.08,
              //     maxHeight: height * 0.08,
              //     child: Row(
              //       children: [
              //         SizedBox(
              //           width: width * 0.05,
              //         ),
              //         _buildIconButton(
              //             context: context,
              //             screenHeight: height,
              //             screenWidth: width,
              //             label: "Map",
              //             width: width * 0.25,
              //             iconData: FontAwesomeIcons.mapMarked),
              //         SizedBox(
              //           width: width * 0.05,
              //         ),
              //         _buildIconButton(
              //           context: context,
              //           screenHeight: height,
              //           screenWidth: width,
              //           label: "Filter",
              //           width: width * 0.25,
              //           iconData: FontAwesomeIcons.filter,
              //         )
              //       ],
              //     ),
              //   ),
              //   pinned: true,
              // ),
            ];
          },
          body: _Body(
            screenHeight: height,
            screenWidth: width,
          ),
        );
      }),
    );
  }

  Widget _buildIconButton({
    required BuildContext context,
    double? screenHeight,
    required double screenWidth,
    double? width,
    required String label,
    IconData? iconData,
  }) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () {},
        child: Ink(
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
              vertical: screenWidth * 0.025,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconData != null)
                  Icon(
                    iconData,
                    color: AppConfig.of(context)!.theme!.greyTextColor,
                    size: width! * 0.16,
                  ),
                if (iconData != null)
                  SizedBox(
                    width: width! * 0.15,
                  ),
                Text(
                  label,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppConfig.of(context)!.theme!.greyTextColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _Body({
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeRestaurantBloc, HomeRestaurantState>(
      buildWhen: (previous, current) =>
          previous.isFetchingInProgress != current.isFetchingInProgress ||
          previous.restuarantList != current.restuarantList,
      builder: (context, state) {
        if (state.isFetchingInProgress) {
          return LoadingScreen();
        } else if (state.restuarantList != null) {
          return Container(
            margin: EdgeInsets.only(
              left: screenWidth * 0.053,
              right: screenWidth * 0.053,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: state.restuarantList
                    .map((item) => _RestuarantRow(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          restaurantModel: item,
                          imageUrl: item.imageUrl!,
                        ))
                    .toList(),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _SearchRestuarantInput extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _SearchRestuarantInput({
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeRestaurantBloc, HomeRestaurantState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return TextFieldStyleOne(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onChanged: (String value) => {},
          textInputAction: TextInputAction.done,
          iconData: Icons.search,
          labelText: 'Search restaurants',
          helperText: '',
          // errorText: state.formSubmitted && state.email.invalid
          //     ? 'Invalid Email'
          //     : null,
        );
      },
    );
  }
}

class _RestuarantRow extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final BasicRestaurantModel restaurantModel;
  final String imageUrl;

  const _RestuarantRow({
    required this.screenHeight,
    required this.screenWidth,
    required this.restaurantModel,
    required this.imageUrl,
  });

  void onRestaurantClicked(BuildContext context) {
    AutoRouter.of(context).push(RestaurantPageRoute(
      restaurantId: restaurantModel.id!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeRestaurantBloc, HomeRestaurantState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: screenHeight * 0.02),
          width: double.infinity,
          child: InkWell(
            onTap: () => onRestaurantClicked(context),
            child: Ink(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.17,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(screenWidth * 0.05),
                        topRight: Radius.circular(screenWidth * 0.05),
                      ),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurantModel.name!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                color:
                                    AppConfig.of(context)!.theme!.accentColor,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        // Text(
                        //   "2 min away (95 m)",
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyText1!
                        //       .copyWith(fontWeight: FontWeight.w400),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
