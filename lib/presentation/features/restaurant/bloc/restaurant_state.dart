part of 'restaurant_bloc.dart';

class RestaurantState extends Equatable {
  final bool isRestaurantFetchInProgress;
  final DetailedRestaurantModel restaurantModel;

  final bool isMenuFetchInProgress;
  final MenuModel menuModel;

  final int currentTabIndex;
  final String errorMessage;

  const RestaurantState({
    this.restaurantModel,
    this.isRestaurantFetchInProgress = false,
    this.menuModel,
    this.isMenuFetchInProgress = false,
    this.currentTabIndex = 0,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        isRestaurantFetchInProgress,
        restaurantModel,
        menuModel,
        isMenuFetchInProgress,
        currentTabIndex,
        errorMessage,
      ];

  RestaurantState copyWith({
    bool isRestaurantFetchInProgress,
    DetailedRestaurantModel restaurantModel,
    bool isMenuFetchInProgress,
    MenuModel menuModel,
    int currentTabIndex,
    String errorMessage,
  }) {
    return RestaurantState(
      isRestaurantFetchInProgress:
          isRestaurantFetchInProgress ?? this.isRestaurantFetchInProgress,
      restaurantModel: restaurantModel ?? this.restaurantModel,
      isMenuFetchInProgress:
          isMenuFetchInProgress ?? this.isMenuFetchInProgress,
      menuModel: menuModel ?? this.menuModel,
      currentTabIndex: currentTabIndex?? this.currentTabIndex,
      errorMessage: errorMessage,
    );
  }
}
