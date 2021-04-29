import 'dart:convert';



import 'package:yummer/domain/restaurant/restaurant.dart';

class DetailedRestaurantModel extends BasicRestaurantModel {
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? stateProvince;
  final String? country;
  final String? zipPostalCode;
  final String? phoneNumber;
  final String? email;
  final String? website;
  final String? posAccountId;

  const DetailedRestaurantModel({
    required String? id,
    required String? name,
    required String? description,
    required String? imageUrl,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.stateProvince,
    required this.country,
    required this.zipPostalCode,
    required this.phoneNumber,
    required this.email,
    required this.website,
    required this.posAccountId,
  }) : super(id: id, name: name, description: description, imageUrl: imageUrl);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        addressLine1,
        addressLine2,
        city,
        stateProvince,
        country,
        zipPostalCode,
        phoneNumber,
        email,
        website,
        posAccountId,
      ];

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'stateProvince': stateProvince,
      'country': country,
      'zipPostalCode': zipPostalCode,
      'phoneNumber': phoneNumber,
      'email': email,
      'website': website,
      'posAccountId': posAccountId,
    };
  }

  factory DetailedRestaurantModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return DetailedRestaurantModel(
      id: map['_id'] as String?,
      name: map['name'] as String?,
      description: map['description'] as String?,
      imageUrl: map['imageUrl'] as String?,
      addressLine1: map['addressLine1'] as String?,
      addressLine2: map['addressLine2'] as String?,
      city: map['city'] as String?,
      stateProvince: map['stateProvince'] as String?,
      country: map['country'] as String?,
      zipPostalCode: map['zipPostalCode'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      email: map['email'] as String?,
      website: map['website'] as String?,
      posAccountId: map['posAccountId'] as String?,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory DetailedRestaurantModel.fromJson(String source) =>
      DetailedRestaurantModel.fromMap(
          json.decode(source) as Map<String, dynamic>?);
}
