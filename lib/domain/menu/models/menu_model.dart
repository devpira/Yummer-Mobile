import 'dart:convert';

import 'package:equatable/equatable.dart';


import 'package:yummer/domain/menu/models/menu_display_group_model.dart';

class MenuModel extends Equatable {
  final String? id;
  final String? restaurantId;
  final String? name;
  final List<MenuDisplayGroupModel> displayGroups;

  const MenuModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.displayGroups,
  });

  @override
  List<Object?> get props => [id, restaurantId, name, displayGroups];

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'restaurantId': restaurantId,
      'name': name,
      'displayGroups': displayGroups?.map((x) => x.toMap())?.toList(),
    };
  }

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      id: map['_id'] as String?,
      restaurantId: map['restaurantId'] as String?,
      name: map['name'] as String?,
      displayGroups: List<MenuDisplayGroupModel>.from(map['displayGroups']?.map((x) => MenuDisplayGroupModel.fromMap(x as Map<String, dynamic>))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuModel.fromJson(String source) => MenuModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
