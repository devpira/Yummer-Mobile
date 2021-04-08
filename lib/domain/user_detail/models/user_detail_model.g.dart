// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailModel _$UserDetailModelFromJson(Map<String, dynamic> json) {
  return UserDetailModel(
    id: json['_id'] as String,
    phoneNumber: json['phoneNumber'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    posCustomerId: json['posCustomerId'] as String,
  );
}

Map<String, dynamic> _$UserDetailModelToJson(UserDetailModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'email': instance.email,
      'posCustomerId': instance.posCustomerId,
    };
