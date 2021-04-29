import 'dart:convert';

import 'package:equatable/equatable.dart';


class ProductModifierModel extends Equatable {
  final String? id;
  final String? name;
  final int? priceUnitAmount;

  const ProductModifierModel({
    required this.id,
    required this.name,
    required this.priceUnitAmount,
  });

  @override
  List<Object?> get props => [id, name, priceUnitAmount];

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'priceUnitAmount': priceUnitAmount,
    };
  }

  factory ProductModifierModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return ProductModifierModel(
      id: map['_id'] as String?,
      name: map['name'] as String?,
      priceUnitAmount: map['priceUnitAmount'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModifierModel.fromJson(String source) =>
      ProductModifierModel.fromMap(json.decode(source) as Map<String, dynamic>?);
}
