import 'dart:convert';

import 'package:equatable/equatable.dart';


import 'package:yummer/domain/menu/models/product_modifier_group_model.dart';

class MenuProductModel extends Equatable {
  final String? id;
  final String? posProductId;
  final int? priceUnitAmount;
  final String? currencyCode;
  final String? name;
  final String? description;
  final List<String> imageUrls;
  final List<ProductModifierGroupModel> modiferGroups;

  const MenuProductModel({
    required this.id,
    required this.posProductId,
    required this.priceUnitAmount,
    required this.currencyCode,
    required this.name,
    required this.description,
    required this.imageUrls,
    required this.modiferGroups,
  });

  @override
  List<Object?> get props {
    return [
      id,
      posProductId,
      priceUnitAmount,
      currencyCode,
      name,
      description,
      imageUrls,
      modiferGroups,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'posProductId': posProductId,
      'priceUnitAmount': priceUnitAmount,
      'currencyCode': currencyCode,
      'name': name,
      'description': description,
      'imageUrls': imageUrls,
      'modiferGroups': modiferGroups.map((x) => x.toMap()).toList(),
    };
  }

  factory MenuProductModel.fromMap(Map<String, dynamic> map) {
    return MenuProductModel(
      id: map['_id'] as String?,
      posProductId: map['posProductId'] as String?,
      priceUnitAmount: map['priceUnitAmount'] as int?,
      currencyCode: map['currencyCode'] as String?,
      name: map['name'] as String?,
      description: map['description'] as String?,
      imageUrls: List<String>.from(map['imageUrls']),
      modiferGroups: List<ProductModifierGroupModel>.from(
        map['modiferGroups'].map(
          (x) => ProductModifierGroupModel.fromMap(
            x as Map<String, dynamic>,
          ),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuProductModel.fromJson(String source) =>
      MenuProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
