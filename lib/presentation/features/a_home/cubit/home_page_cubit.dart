import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:injectable/injectable.dart';


part 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
      : super(HomePageState(currentView: HomePageRestaurantsView()));

  void changeHomePageView({required int index}) {
    HomePageViewType? viewType;
    print(index);
    switch (index) {
      case 0:
        viewType = HomePageRestaurantsView();
        break;
      case 1:
        viewType = HomePageSocialView();
        break;
      case 2:
        viewType = HomePageOrderHistoryView();
        break;
      case 3:
        viewType = HomePageProfileView();
        break;
      default:
        break;
    }
    print(viewType);
    emit(state.copyWith(bottomNavIndex: index, currentView: viewType));
  }
}
