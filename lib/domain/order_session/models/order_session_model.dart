import 'dart:convert';

import 'package:equatable/equatable.dart';


import 'order_session_cart_item_model.dart';

class OrderSessionModel extends Equatable {
  final String? id;
  final String? restaurantId;
  final String? paymentHoldChargeId;
  final String? tableId;
  final String? invoiceId;
  final int? totalCostUnitAmount;
  final int? orderStatus;
  final List<OrderSessionCartItemModel> cart;

  const OrderSessionModel({
    required this.id,
    required this.restaurantId,
    required this.paymentHoldChargeId,
    required this.tableId,
    required this.invoiceId,
    required this.totalCostUnitAmount,
    required this.orderStatus,
    required this.cart,
  });

  @override
  List<Object?> get props {
    return [
      id,
      restaurantId,
      paymentHoldChargeId,
      tableId,
      invoiceId,
      totalCostUnitAmount,
      orderStatus,
      cart,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'restaurantId': restaurantId,
      'paymentHoldChargeId': paymentHoldChargeId,
      'tableId': tableId,
      'invoiceId': invoiceId,
      'totalCostUnitAmount': totalCostUnitAmount,
      'orderStatus': orderStatus,
      'cart': cart?.map((x) => x.toMap())?.toList(),
    };
  }

  factory OrderSessionModel.fromMap(Map<String, dynamic> map) {
    return OrderSessionModel(
      id: map['_id'] as String?,
      restaurantId: map['restaurantId'] as String?,
      paymentHoldChargeId: map['paymentHoldChargeId'] as String?,
      tableId: map['tableId'] as String?,
      invoiceId: map['invoiceId'] as String?,
      totalCostUnitAmount: map['totalCostUnitAmount'] as int?,
      orderStatus: map['orderStatus'] as int?,
      // ignore: argument_type_not_assignable
      cart: List<OrderSessionCartItemModel>.from(
        // ignore: argument_type_not_assignable
          map['cart']?.map((x) => OrderSessionCartItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderSessionModel.fromJson(String source) =>
      OrderSessionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
