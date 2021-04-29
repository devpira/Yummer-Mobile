import 'dart:convert';

import 'package:equatable/equatable.dart';


class OrderSessionProductModel extends Equatable {
  final String? id;
  final int? priceUnitAmount;
  final String? currencyCode;
  final String? name;
  final String? description;
  final List<String> imageUrls;

  const OrderSessionProductModel({
    required this.id,
    required this.priceUnitAmount,
    required this.currencyCode,
    required this.name,
    required this.description,
    required this.imageUrls,
  });

  @override
  List<Object?> get props {
    return [
      id,
      priceUnitAmount,
      currencyCode,
      name,
      description,
      imageUrls,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'priceUnitAmount': priceUnitAmount,
      'currencyCode': currencyCode,
      'name': name,
      'description': description,
      'imageUrls': imageUrls,
    };
  }

  factory OrderSessionProductModel.fromMap(Map<String, dynamic> map) {
    return OrderSessionProductModel(
      id: map['_id'] as String?,
      priceUnitAmount: map['priceUnitAmount'] as int?,
      currencyCode: map['currencyCode'] as String?,
      name: map['name'] as String?,
      description: map['description'] as String?,
      // ignore: argument_type_not_assignable
      imageUrls: List<String>.from(map['imageUrls']), 
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderSessionProductModel.fromJson(String source) =>
      OrderSessionProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
