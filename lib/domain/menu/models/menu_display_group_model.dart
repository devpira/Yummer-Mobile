import 'dart:convert';

import 'package:equatable/equatable.dart';


import 'package:yummer/domain/menu/models/menu_product_model.dart';

class MenuDisplayGroupModel extends Equatable {
  final String? id;
  final String? name;
  final List<MenuProductModel> products;

  const MenuDisplayGroupModel({
    required this.id,
    required this.name,
    required this.products,
  });

  @override
  List<Object?> get props => [id, name, products];

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory MenuDisplayGroupModel.fromMap(Map<String, dynamic> map) {
    return MenuDisplayGroupModel(
      id: map['_id'] as String?,
      name: map['name'] as String?,
      products: List<MenuProductModel>.from(map['products']?.map((x) => MenuProductModel.fromMap(x as Map<String, dynamic>))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuDisplayGroupModel.fromJson(String source) => MenuDisplayGroupModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
