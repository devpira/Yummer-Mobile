import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return const Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: BottomBarWithSheet(
      //   sheetChild: const Center(child: Text("Place for your another content")),
      //   bottomBarTheme: BottomBarTheme(
      //     mainButtonPosition: MainButtonPosition.Right,
      //     selectedItemBackgroundColor: const Color(0xFF2B65E3),
      //   ),
      //   duration: const Duration(milliseconds: 300),
      //   mainActionButtonTheme: MainActionButtonTheme(
      //     size: screenWidth * 0.14,
      //     iconOpened: const Icon(
      //       Icons.close,
      //       color: Colors.white,
      //     ),
      //     splash: AppConfig.of(context).theme.primaryColor,
      //     color: AppConfig.of(context).theme.primaryColor,
      //     icon: const Icon(
      //       Icons.menu,
      //       color: Colors.white,
      //     ),
      //   ),
      //   onSelectItem: (int index) =>
      //       context.read<HomePageCubit>().changeHomePageView(index: index),
      //   items: [
      //     BottomBarWithSheetItem(
      //       icon: FontAwesomeIcons.globeAmericas,
      //       label: "Upcoming",
      //       selectedBackgroundColor: AppConfig.of(context).theme.primaryColor,
      //     ),
      //     BottomBarWithSheetItem(
      //       icon: FontAwesomeIcons.suitcaseRolling,
      //       label: "Trips",
      //       selectedBackgroundColor: AppConfig.of(context).theme.primaryColor,
      //     ),
      //     BottomBarWithSheetItem(
      //       icon: Icons.search,
      //       label: "Explore",
      //       selectedBackgroundColor: AppConfig.of(context).theme.primaryColor,
      //     ),
      //     BottomBarWithSheetItem(
      //       icon: Icons.person,
      //       label: "Me",
      //       selectedBackgroundColor: AppConfig.of(context).theme.primaryColor,
      //     ),
      //   ],
      // ),
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
        if (state.currentView is HomePageTripsView) {
          return Container();
        } else if(state.currentView is HomePageMeView){
          return Container();
        }
         else {
          return const SystemErrorPage();
        }
      },
    );
  }
}
