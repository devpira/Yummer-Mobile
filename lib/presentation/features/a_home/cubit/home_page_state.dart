part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  final int bottomNavIndex;
  final HomePageViewType? currentView;

  const HomePageState({
    this.bottomNavIndex = 0,
    this.currentView,
  });

  @override
  List<Object?> get props => [bottomNavIndex, currentView];

  HomePageState copyWith({
    int? bottomNavIndex,
    HomePageViewType? currentView,
  }) {
    return HomePageState(
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      currentView: currentView ?? this.currentView,
    );
  }
}

abstract class HomePageViewType extends Equatable {
  @override
  List<Object> get props => [];
}

class HomePageRestaurantsView extends HomePageViewType {}

class HomePageSocialView extends HomePageViewType {}

class HomePageOrderHistoryView extends HomePageViewType {}

class HomePageProfileView extends HomePageViewType {}
