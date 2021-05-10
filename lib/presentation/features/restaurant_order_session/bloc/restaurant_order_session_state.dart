part of 'restaurant_order_session_bloc.dart';

class RestaurantOrderSessionState extends Equatable {
  final OrderSessionModel? orderSessionModel;
  const RestaurantOrderSessionState({
    this.orderSessionModel,
  });

  @override
  List<Object?> get props => [orderSessionModel];

  RestaurantOrderSessionState copyWith({
    OrderSessionModel? orderSessionModel,
  }) {
    return RestaurantOrderSessionState(
      orderSessionModel: orderSessionModel ?? this.orderSessionModel,
    );
  }
}
