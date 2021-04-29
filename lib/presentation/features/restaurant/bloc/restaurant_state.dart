part of 'restaurant_bloc.dart';

class RestaurantState extends Equatable {
  final bool isRestaurantFetchInProgress;
  final DetailedRestaurantModel? restaurantModel;

  final bool isMenuFetchInProgress;
  final MenuModel? menuModel;
  final OrderCartModel? orderCartModel;

  final int currentTabIndex;
  final String? errorMessage;

  final bool isOrderPlaceRequestInProgress;
  final OrderSessionModel? orderSessionModel;

  const RestaurantState({
    this.restaurantModel,
    this.isRestaurantFetchInProgress = false,
    this.menuModel,
    this.orderCartModel,
    this.isMenuFetchInProgress = false,
    this.currentTabIndex = 0,
    this.errorMessage,
    this.isOrderPlaceRequestInProgress = false,
    this.orderSessionModel,
  });

  @override
  List<Object?> get props => [
        isRestaurantFetchInProgress,
        restaurantModel,
        menuModel,
        orderCartModel,
        isMenuFetchInProgress,
        currentTabIndex,
        errorMessage,
        isOrderPlaceRequestInProgress,
        orderSessionModel,
      ];

  RestaurantState copyWith({
    bool? isRestaurantFetchInProgress,
    DetailedRestaurantModel? restaurantModel,
    bool? isMenuFetchInProgress,
    MenuModel? menuModel,
    OrderCartModel? orderCartModel,
    int? currentTabIndex,
    String? errorMessage,
    bool? isOrderPlaceRequestInProgress,
    OrderSessionModel? orderSessionModel,
  }) {
    return RestaurantState(
      isRestaurantFetchInProgress:
          isRestaurantFetchInProgress ?? this.isRestaurantFetchInProgress,
      restaurantModel: restaurantModel ?? this.restaurantModel,
      isMenuFetchInProgress:
          isMenuFetchInProgress ?? this.isMenuFetchInProgress,
      menuModel: menuModel ?? this.menuModel,
      orderCartModel: orderCartModel ?? this.orderCartModel,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      errorMessage: errorMessage,
      isOrderPlaceRequestInProgress: isOrderPlaceRequestInProgress?? false,
      orderSessionModel: orderSessionModel?? this.orderSessionModel,
    );
  }
}
