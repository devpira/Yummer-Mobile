import 'dart:convert';

import 'package:equatable/equatable.dart';


import 'order_session_product_model.dart';

class OrderSessionCartItemModel extends Equatable {
  final OrderSessionProductModel product;
  final int? status;

  const OrderSessionCartItemModel({
    required this.product,
    required this.status
  });

  @override
  List<Object?> get props {
    return [
      product,
      status
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'status': status,
    };
  }

  factory OrderSessionCartItemModel.fromMap(Map<String, dynamic> map) {
    return OrderSessionCartItemModel(
      product: OrderSessionProductModel.fromMap(map['product'] as Map<String, dynamic>),
      status: map['status'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderSessionCartItemModel.fromJson(String source) => OrderSessionCartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
