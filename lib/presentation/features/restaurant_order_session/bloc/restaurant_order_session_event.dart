part of 'restaurant_order_session_bloc.dart';

class RestaurantOrderSessionEvent extends Equatable {
  const RestaurantOrderSessionEvent();

  @override
  List<Object> get props => [];
}

class RestaurantOrderSessionEventStartOrderSession extends RestaurantOrderSessionEvent {
  final OrderSessionModel orderSessionModel;

  const RestaurantOrderSessionEventStartOrderSession({
    required this.orderSessionModel,
  });
}
