part of 'restaurant_order_session_bloc.dart';

abstract class RestaurantOrderSessionState extends Equatable {
  const RestaurantOrderSessionState();
  
  @override
  List<Object> get props => [];
}

class RestaurantOrderSessionInitial extends RestaurantOrderSessionState {}
