import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/presentation/features/feature.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<HomePageCubit>(
        create: (_) => getIt<HomePageCubit>(),
        child: const _HomePageView(),
      ),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BlocBuilder<HomePageCubit, HomePageState>(
          buildWhen: (previous, current) =>
              previous.bottomNavIndex != current.bottomNavIndex,
          builder: (context, state) {
            return AnimatedBottomNavigationBar(
              icons: [
                FontAwesomeIcons.home,
                FontAwesomeIcons.users,
                FontAwesomeIcons.solidClock,
                FontAwesomeIcons.solidUser,
              ],
              activeIndex: state.bottomNavIndex,
              //iconSize: screenWidth * 0.07,
              inactiveColor: Colors.white60,
              backgroundColor: AppConfig.of(context).theme.primaryColor,
              activeColor: Colors.white,
              gapLocation: GapLocation.none,
              splashColor: AppConfig.of(context).theme.primaryColor,
              elevation: 5,
              leftCornerRadius: 15,
              rightCornerRadius: 15,
              onTap: (index) => context
                  .read<HomePageCubit>()
                  .changeHomePageView(index: index),
            );
          }),
      body: const _HomePageBody(
        key: Key('homePage_view'),
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      buildWhen: (previous, current) =>
          previous.bottomNavIndex != current.bottomNavIndex,
      builder: (context, state) {
        if (state.currentView is HomePageRestaurantsView) {
          return HomeRestaurantPage();
        } else if (state.currentView is HomePageSocialView) {
          return const SizedBox(
            child: Center(
              child: Text("COMING SOON!"),
            ),
          );
        } else if (state.currentView is HomePageOrderHistoryView) {
          return const SizedBox(
            child: Center(
              child: Text("COMING SOON!"),
            ),
          );
        } else if (state.currentView is HomePageProfileView) {
          return HomeProfilePage();
        } else {
          return const SystemErrorPage();
        }
      },
    );
  }
}
