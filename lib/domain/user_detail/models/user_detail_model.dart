import 'package:json_annotation/json_annotation.dart';

part 'user_detail_model.g.dart';

@JsonSerializable()
class UserDetailModel {
  @JsonKey(name: '_id')
  String id;
  String firstName;
  String lastName;
  String email;

  UserDetailModel({this.id, this.firstName, this.lastName, this.email});

  factory UserDetailModel.fromJson(Map<String, dynamic> data) => _$UserDetailModelFromJson(data);

  Map<String, dynamic> toJson() => _$UserDetailModelToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  factory UserDetailModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserDetailModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
    );
  }
}
