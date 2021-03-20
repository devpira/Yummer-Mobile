import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState());

  void changeHomePageView({@required int index}) {
    HomePageViewType viewType;
    print(index);
    switch (index) {
      case 0:
        viewType = HomePageUpcomingView();
        break;
      case 1:
        viewType = HomePageTripsView();
        break;
      case 2:
        viewType = HomePageExploreView();
        break;
      case 3:
        viewType = HomePageMeView();
        break;
      default:
        break;
    }
    print(viewType);
    emit(state.copyWith(bottomNavIndex: index, currentView: viewType));
  }
}
