import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:yummer/domain/order_cart/models/order_cart_item_model.dart';

class OrderCartModel extends Equatable {
  final String id;
  final String restaurantId;
  final int totalPriceUnitAmount;
  final List<OrderCartItemModel> cartItems;

  const OrderCartModel({
    @required this.id,
    @required this.restaurantId,
    @required this.cartItems,
    this.totalPriceUnitAmount = 0,
  });

  @override
  List<Object> get props => [id, restaurantId, totalPriceUnitAmount, cartItems];


  OrderCartModel copyWith({
    String id,
    String restaurantId,
    int totalPriceUnitAmount,
    List<OrderCartItemModel> cartItems,
  }) {
    return OrderCartModel(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      totalPriceUnitAmount: totalPriceUnitAmount ?? this.totalPriceUnitAmount,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
