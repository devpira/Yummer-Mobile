import 'package:json_annotation/json_annotation.dart';

part 'user_detail_model.g.dart';

@JsonSerializable()
class UserDetailModel {
  @JsonKey(name: '_id')
  String id;
  String phoneNumber;
  String name;
  String email;

  UserDetailModel({this.id, this.phoneNumber, this.name, this.email});

  factory UserDetailModel.fromJson(Map<String, dynamic> data) => _$UserDetailModelFromJson(data);

  Map<String, dynamic> toJson() => _$UserDetailModelToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
    };
  }

  factory UserDetailModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserDetailModel(
      id: map['id'] as String,
      phoneNumber: map['phoneNumber'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }
}
