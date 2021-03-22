part of 'home_restaurant_bloc.dart';

class HomeRestaurantState extends Equatable {
  final bool isFetchingInProgress;
  final List<BasicRestaurantModel> restuarantList;

  const HomeRestaurantState({
    @required this.restuarantList,
    this.isFetchingInProgress = false,
  });

  @override
  List<Object> get props => [isFetchingInProgress, restuarantList];

  HomeRestaurantState copyWith({
    bool isFetchingInProgress,
    List<BasicRestaurantModel> restuarantList,
  }) {
    return HomeRestaurantState(
      isFetchingInProgress: isFetchingInProgress ??false,
      restuarantList: restuarantList ?? this.restuarantList,
    );
  }
}
