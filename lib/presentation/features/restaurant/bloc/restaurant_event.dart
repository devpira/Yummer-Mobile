part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class RestaurantEventLoadRestaurant extends RestaurantEvent {
  final String restaurantId;

  const RestaurantEventLoadRestaurant({
    @required this.restaurantId,
  });
}

class RestaurantEventLoadMenu extends RestaurantEvent {
  final String restaurantId;

  const RestaurantEventLoadMenu({
    @required this.restaurantId,
  });
}

class RestaurantEventChangeCurrentMenuTab extends RestaurantEvent {
  final int index;
  
  const RestaurantEventChangeCurrentMenuTab({
    @required this.index,
  });
}
