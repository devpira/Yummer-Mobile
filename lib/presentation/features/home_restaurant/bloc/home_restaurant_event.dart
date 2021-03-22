part of 'home_restaurant_bloc.dart';

abstract class HomeRestaurantEvent extends Equatable {
  const HomeRestaurantEvent();

  @override
  List<Object> get props => [];
}

class HomeRestaurantEventLoadAllBasicRestaurants extends HomeRestaurantEvent {}