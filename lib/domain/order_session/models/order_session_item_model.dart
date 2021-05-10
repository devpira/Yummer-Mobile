import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'order_session_product_model.dart';

class OrderSessionItemModel extends Equatable {
  final OrderSessionProductModel product;
  final int status;
  final int quantity;
  final int originalPriceUnitAmount;

  const OrderSessionItemModel({
    required this.product,
    required this.status,
    required this.quantity,
    required this.originalPriceUnitAmount,
  });

  @override
  List<Object> get props {
    return [
      product,
      status,
      quantity,
      originalPriceUnitAmount,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'status': status,
    };
  }

  factory OrderSessionItemModel.fromMap(Map<String, dynamic> map) {
    return OrderSessionItemModel(
      product: OrderSessionProductModel.fromMap(
          map['product'] as Map<String, dynamic>),
      status: map['status'] as int,
      quantity: map['quantity'] as int,
      originalPriceUnitAmount: map['originalPriceUnitAmount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderSessionItemModel.fromJson(String source) =>
      OrderSessionItemModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
