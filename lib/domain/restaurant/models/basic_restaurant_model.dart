import 'dart:convert';

import 'package:equatable/equatable.dart';

class BasicRestaurantModel extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;

  const BasicRestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, description, imageUrl];

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  static const empty =
      BasicRestaurantModel(id: '', name: '', description: '', imageUrl: '');

  factory BasicRestaurantModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return BasicRestaurantModel.empty;
    }

    return BasicRestaurantModel(
      id: map['_id'] as String?,
      name: map['name'] as String?,
      description: map['description'] as String?,
      imageUrl: map['imageUrl'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory BasicRestaurantModel.fromJson(String source) =>
      BasicRestaurantModel.fromMap(
          json.decode(source) as Map<String, dynamic>?);
}
