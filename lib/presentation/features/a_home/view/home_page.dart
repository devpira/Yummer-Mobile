import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yummer/config/app_config.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:yummer/config/config.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/feature.dart';
import 'package:yummer/presentation/features/home_social/home_social.dart';

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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
  final userDetails = context.select((UserDetailBloc bloc) {
      if (bloc.state is UserDetailLoaded) {
        return (bloc.state as UserDetailLoaded).userDetails;
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BlocBuilder<HomePageCubit, HomePageState>(
          buildWhen: (previous, current) =>
              previous.bottomNavIndex != current.bottomNavIndex,
          builder: (context, state) {
            return BottomNavigationBar(
              backgroundColor: const Color(0xffF2F2F2),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.grey[400],
              type: BottomNavigationBarType.fixed,
              elevation: 20,
              items:  <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.home),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.users),
                  label: 'Home',
                ),
                // const BottomNavigationBarItem(
                //   icon: Icon(FontAwesomeIcons.solidClock),
                //   label: 'Home',
                // ),
                BottomNavigationBarItem(
                  icon: CachedAvatarImage(
                    imageUrl: userDetails != null && userDetails.profileImageUrl != ""? userDetails.profileImageUrl!:
                        null,
                    radius: screenWidth * 0.045,
                    borderWidth: screenWidth * 0.008,
                    borderColor: state.bottomNavIndex == 2? AppConfig.of(context)!.theme!.primaryColor :Colors.white,
                  ),
                  label: 'Home',
                ),
              ],
              currentIndex: state.bottomNavIndex,
              selectedItemColor: Colors.amber[800],
              onTap: (index) => context
                  .read<HomePageCubit>()
                  .changeHomePageView(index: index),
            );
            // return AnimatedBottomNavigationBar(
            //   icons: [
            //     FontAwesomeIcons.home,
            //     FontAwesomeIcons.users,
            //     FontAwesomeIcons.solidClock,
            //     FontAwesomeIcons.solidUser,
            //   ],
            //   activeIndex: state.bottomNavIndex,
            //   //iconSize: screenWidth * 0.07,
            //   inactiveColor: Colors.white60,
            //   backgroundColor: AppConfig.of(context)!.theme!.primaryColor,
            //   activeColor: Colors.white,
            //   gapLocation: GapLocation.none,
            //   splashColor: AppConfig.of(context)!.theme!.primaryColor,
            //   elevation: 5,
            //   leftCornerRadius: 15,
            //   rightCornerRadius: 15,
            //   onTap: (index) => context
            //       .read<HomePageCubit>()
            //       .changeHomePageView(index: index),
            // );
          }),
      body: const _HomePageBody(
        key: Key('homePage_view'),
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    Key? key,
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
          return HomeSocialPage();
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
