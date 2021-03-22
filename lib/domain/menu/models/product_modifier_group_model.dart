import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:yummer/domain/menu/models/product_modifier_model.dart';

class ProductModifierGroupModel extends Equatable {
  final String id;
  final String name;
  final int minSelection;
  final int maxSelection;
  final List<ProductModifierModel> modifiers;

  const ProductModifierGroupModel({
    @required this.id,
    @required this.name,
    @required this.minSelection,
    @required this.maxSelection,
    @required this.modifiers,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      minSelection,
      maxSelection,
      modifiers,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'minSelection': minSelection,
      'maxSelection': maxSelection,
      'modifiers': modifiers?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ProductModifierGroupModel.fromMap(Map<String, dynamic> map) {
    return ProductModifierGroupModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      minSelection: map['minSelection'] as int,
      maxSelection: map['maxSelection'] as int,
      modifiers: List<ProductModifierModel>.from(
        map['modifiers']?.map(
          (x) => ProductModifierModel.fromMap(
            x as Map<String, dynamic>,
          ),
        ) ,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModifierGroupModel.fromJson(String source) =>
      ProductModifierGroupModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
